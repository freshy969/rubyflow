class PostsController < ApplicationController
  def index
    @posts = ::Post.all
  end

  def show
    @post = ::Post.find(params[:id])
    @post = ::PostDecorator.decorate(@post)
  end
end
