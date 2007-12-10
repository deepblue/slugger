class ApplicationController < ActionController::Base
  helper :all
  before_filter :load_site
  attr_reader   :site
    
protected

  def load_site
    @site =  Site.new
  end

  def render_template(name)
    @template.view_paths = [@site.theme.root]
    ::Liquid::Template.file_system = ::Liquid::LocalFileSystem.new(File.join(site.theme.root, 'templates'))
    
    render :file => site.theme.template(name), :layout => 'layout'
  end

  def render_404
    render_template('error')
  end
  
  def page(page_id)
    Page.find(page_id.to_i) if Page.blog_post?(page_id)
  end
end
