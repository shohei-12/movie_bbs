class UsersController < ApplicationController
  before_action :check_user, only: %i[edit update]
  before_action :check_admin, only: :destroy

  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(
      :image,
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  # before action

  # Check user is self
  def check_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  # Check user is admin
  def check_admin
    redirect_to root_url unless current_user.admin?
  end
end
