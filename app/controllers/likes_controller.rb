class LikesController < ApplicationController
  before_action :check_logged_in
  before_action :set_variables

  def create
    @like = current_user.likes.create(post_id: @post.id)
  end

  def destroy
    @like = current_user.likes.find_by(post_id: @post.id)
    @like.destroy
  end

  private

  # before action

  def set_variables
    @post = Post.find(params[:post_id])
  end
end
