class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @posts = ::Post.all
    @posts = ::PostDecorator.decorate_collection(@posts).group_by(&:created_at)
  end

  def show
    @post = ::Post.find(params[:id])
    @post = ::PostDecorator.decorate(@post)
  end

  def new
    @post = ::Post.new
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

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
