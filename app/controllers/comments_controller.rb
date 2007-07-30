class CommentsController < ApplicationController
  def create
    @page = Page.find(params[:page_id])
    @comment = Comment.create @page, params[:comment]
    redirect_to :back
  end
end
