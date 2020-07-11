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
      log_in @user
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    if params[:category]
      @category = Category.find(params[:category])
      @posts = @user.posts.where(category_id: @category.id).page(params[:page]).order(created_at: :desc)
    else
      @posts = @user.posts.page(params[:page]).order(created_at: :desc)
    end
  end

  def popular_posts
    @user = User.find(params[:id])
    @posts = @user.posts.joins(:likes).group(:post_id).order('count(post_id) desc').page(params[:page]).order(created_at: :desc)
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
