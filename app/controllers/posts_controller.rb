class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update, :show, :destroy]
  before_action :redirect_unless_authorized, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def new
    @post = Post.new
  end

  def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = "Post was successfully created!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
   end

   def destroy
     @post.destroy
     flash[:notice] = "Post was successfully deleted!"
     redirect_to posts_path
   end

private
  def post_params
      params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def redirect_unless_authorized
    unless current_user == @post.user || current_user.admin?
      flash[:danger] = "You can only edit or delete your own posts"
      redirect_to root_path
    end
  end
end
