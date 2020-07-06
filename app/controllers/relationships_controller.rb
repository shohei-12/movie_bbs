class RelationshipsController < ApplicationController
  before_action :check_logged_in
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following
      flash[:success] = "#{@user.name}さんをフォローしました！"
      redirect_to @user
    else
      flash[:danger] = "#{@user.name}さんのフォローに失敗しました。"
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following
      flash[:success] = "#{@user.name}さんのフォローを解除しました！"
      redirect_to @user
    else
      flash[:danger] = "#{@user.name}さんのフォロー解除に失敗しました。"
      redirect_to @user
    end
  end

  private

  # before action

  def set_user
    @user = User.find_by(id: params[:relationship][:follow_id])
  end
end
