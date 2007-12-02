require "xmlrpc/parser"
require "xmlrpc/create"
require "xmlrpc/config"
require "xmlrpc/utils"         # ParserWriterChooseMixin


class XmlrpcController < ApplicationController
  session :off
  
  include XMLRPC::ParserWriterChooseMixin
  include XMLRPC::ParseContentType

  def api
    name, data = parser.parseMethodCall(request.body)
    name.gsub!(/\./, '_')
    
    ret = send(name.to_sym, *data)
    xml = create.methodResponse(true, *ret)
    render :text => xml, :content_type => 'text/xml; charset=utf-8'
  end
  
protected
  # http://www.hixie.ch/specs/pingback/pingback
  def pingback_ping(source_uri, target_uri)
    RAILS_DEFAULT_LOGGER.info "ping #{source_uri}, #{target_uri}"
    
    # to prevent duplicated posts in me2day
    return 0 if source_uri =~ /me2day.net\/#{Site.me2day_user_id}\//
    
    match = target_uri.scan(/\/pages\/(\d+)/)
    page_id = match[0].to_s.to_i
    return 0x0020 if page_id <= 0 || !Page.blog_post?(page_id)
    
    page = Page.find(page_id)
    return 0x0020 unless page
    
    Comment.create_pingback page, source_uri
    0
  end
end