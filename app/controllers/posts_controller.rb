class PostsController < ApplicationController
  before_action :check_logged_in, only: %i[new create]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :content
    )
  end

  # before action

  # Check user is logged in
  def check_logged_in
    redirect_to login_url unless logged_in?
  end
end
