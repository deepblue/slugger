class ApplicationController < ActionController::Base
  helper :all
  
protected
  def render_404
    render :file => RAILS_ROOT + '/public/404.html', :layout => false, :status => 404
  end
  
  def page(page_id)
    Page.find(page_id.to_i) if Page.blog_post?(page_id.to_i)
  end
end
