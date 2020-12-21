class CommentsController < ApplicationController
  def new
    @comments = Comment.all
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.sever.broadcast 'comment_channel', content: @comment
    end
  end

  private

  def comment_params
    params.permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
