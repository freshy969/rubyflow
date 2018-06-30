class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = ::Post.find_by!(slug: params[:post_id])
    comment = ::Comment.new(
      body: comments_params[:body], user_id: current_user.id, post_id: post.id
    )

    notification = if comment.save
      { success: 'Comment added successfully!' }
    else
      { error: 'Please provide the comment body!' }
    end

    redirect_to(post_path(id: post.slug), gflash: notification)
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
