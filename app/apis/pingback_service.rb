require 'pingback_api'

class PingbackService < ActionWebService::Base
  web_service_api PingbackAPI
  
  def ping(source_uri, target_uri)
    RAILS_DEFAULT_LOGGER.info "ping #{source_uri}, #{target_uri}"
    
    match = target_uri.scan(/\/pages\/(\d+)/)
    
    page_id = match[0].to_s.to_i
    return 0x0020 if page_id <= 0 || !Page.blog_post?(page_id)
    
    page = Page.find(page_id)
    return 0x0020 unless page
    
    Comment.create_pingback page, source_uri
    0
  end
end