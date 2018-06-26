class PostsController < ApplicationController
  def index
    @posts = ::Post.all
    @posts = ::PostDecorator.decorate_collection(@posts).group_by(&:created_at)
  end

  def show
    @post = ::Post.find(params[:id])
    @post = ::PostDecorator.decorate(@post)
  end
end
