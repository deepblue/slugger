class PagesController < ApplicationController
  caches_action :index, :cache_path => Proc.new{|controller| controller.send(:pages_url, :no => controller.params[:no] || 1)}
  
  def index
    return search if params[:q]
    
    @page_no, list_per_page = request.format.atom? ? [1, Site.list_per_page_atom] : [(params[:no] || 1).to_i, Site.list_per_page]
    @articles = Page.list[(@page_no-1)*list_per_page...(@page_no)*list_per_page].map{|id| Page.find(id)}

    respond_to do |format|      
      format.html { render_template 'home' }
      format.atom { render :layout => false }
    end
  end
    
  def show    
    @article = page(params[:id])
    return render_404 unless @article
    @articles = [@article]    
    
    render_template 'single'
  end
  
protected
  def search
    @search_string = params[:q]
    @articles = Page.search(@search_string).select{|page| page.blog_post?}
  
    render_template 'search'
  end
end