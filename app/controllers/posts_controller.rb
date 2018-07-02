class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def rss
    @posts = ::Posts::RSSQuery.call
  end

  def index
    @posts = ::Posts::ListQuery.call(offset: params[:offset])
    @posts = ::PostDecorator.decorate_collection(@posts)

    respond_to do |format|
      format.html { @posts = @posts.group_by(&:created_at) }
      format.json { render json: @posts }
    end
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
      redirect_to(post_path(id: @post.slug), gflash: { success: "Post updated successfully!" })
    else
      render :edit
    end
  end

  def create
    @post = ::Post.new(
      user_id: current_user.id, title: post_params[:title], content: post_params[:content]
    )

    if @post.save
      respond_to do |format|
        format.html do
          redirect_to(post_path(id: @post.slug), gflash: { success: "Post added successfully!" })
        end
        format.json { render json: { slug: @post.slug }, status: 201 }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = ::Users::FindPostQuery.call(
      post_id: params[:id], user: current_user
    )

    @post.destroy

    redirect_to(:root, gflash: { success: "Post destroyed successfully!" })
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
