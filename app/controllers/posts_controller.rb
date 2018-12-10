class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = "Post was successfully created!"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
   end

private
  def post_params
      params.require(:post).permit(:title, :body)
  end
end
