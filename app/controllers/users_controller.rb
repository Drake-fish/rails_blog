class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :redirect_unless_authorized, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "welcome to the Blog! #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def index
    @users = User.includes(:posts).all
  end

  def update

    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end

  def redirect_unless_authorized
    unless current_user == @user || current_user.admin?
      flash[:danger] = "You cannot edit someone elses profile!"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
