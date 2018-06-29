class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = ::Post.find(params[:post_id])
    comment = ::Comment.new(
      body: comments_params[:body], user_id: current_user.id, post_id: post.id
    )

    comment.save

    redirect_to post_path(id: post.id)
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
