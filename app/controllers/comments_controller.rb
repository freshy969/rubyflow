class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = ::Post.find_by!(slug: params[:post_id])
    comment = ::Comment.new(
      body: comments_params[:body], user_id: current_user.id, post_id: post.id
    )

    if comment.save
      respond_to do |format|
        format.html { redirect_to(post_path(id: post.slug), gflash: { success: 'Comment added successfully!' }) }
        format.json { render json: { success: true, message: 'Comment added successfully!' } }
      end
    else
      respond_to do |format|
        format.html { redirect_to(post_path(id: post.slug), gflash: { error: 'Please provide the comment body!' }) }
        format.json { render json: { success: false, message: 'Please provide the comment body!' }, status: :unprocessable_entity }
      end
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
