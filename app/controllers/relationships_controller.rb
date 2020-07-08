class RelationshipsController < ApplicationController
  before_action :check_logged_in
  before_action :set_user

  def create
    current_user.follow(@user)
  end

  def destroy
    current_user.unfollow(@user)
  end

  private

  # before action

  def set_user
    @user = User.find_by(id: params[:relationship][:follow_id])
  end
end
