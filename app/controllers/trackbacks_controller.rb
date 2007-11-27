class TrackbacksController < ApplicationController
  
  def create
    @page = page(params[:page_id])
    return render_404 unless @page
    
    @comment = Comment.create_trackback(@page, params)
    render(:xml => {:response => {:error => 0}})
  end
end