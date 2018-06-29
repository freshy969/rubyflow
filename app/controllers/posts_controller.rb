class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def rss
    @posts = ::Posts::RSSQuery.call
  end

  def index
    @posts = ::Posts::ListQuery.call
    @posts = ::PostDecorator.decorate_collection(@posts).group_by(&:created_at)
  end

  def show
    @post = ::Posts::FindQuery.call(params[:id])
    @post = ::PostDecorator.decorate(@post, context: { current_user: current_user })
    @comment = ::Comment.new
  end

  def new
    @post = ::Post.new
  end

  def edit
    @post = ::Users::FindPostQuery.call(
      post_id: params[:id], user: current_user
    )
  end

  def update
    @post = ::Users::FindPostQuery.call(
      post_id: params[:id], user: current_user
    )

    if @post.update_attributes(title: post_params[:title], content: post_params[:content])
      redirect_to post_path(id: @post.id)
    else
      render :edit
    end
  end

  def create
    @post = ::Post.new(
      user_id: current_user.id, title: post_params[:title], content: post_params[:content]
    )

    if @post.save
      redirect_to post_path(id: @post.id)
    else
      render :new
    end
  end

  def destroy
    @post = ::Users::FindPostQuery.call(
      post_id: params[:id], user: current_user
    )

    @post.destroy

    redirect_to(:root)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
