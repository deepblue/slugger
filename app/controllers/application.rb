class ApplicationController < ActionController::Base
  helper :all
  
protected
  def render_404
    render :file => RAILS_ROOT + '/public/404.html', :layout=>false, :status => 404
  end
end
