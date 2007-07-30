class PagesController < ApplicationController
  caches_action :index
  
  def index
    @page_no, list_per_page = request.format.atom? ? [1, Site.list_per_page_atom] : [(params[:no] || 1).to_i, Site.list_per_page]
    @pages = Page.list[(@page_no-1)*list_per_page...(@page_no)*list_per_page].map{|id| Page.find(id)}

    respond_to do |format|      
      format.html
      format.atom { render :layout => false }
    end
  end
  
  def show
    return render_404 unless Page.blog_post?(params[:id].to_i)    
    @page = Page.find(params[:id])
    @comments = Comment.find(@page)
  end
end