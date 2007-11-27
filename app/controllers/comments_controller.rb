class CommentsController < ApplicationController
  def create
    @page = page(params[:page_id]) 
    return render_404 unless @page

    @comment = Comment.create @page, params[:comment]
    redirect_to :back
  end
end
