class PostsController < ApplicationController
  before_action :check_logged_in, only: %i[new create destroy]

  def index
    if params[:category]
      @category = Category.find(params[:category])
      @posts = @category.posts.page(params[:page]).order(created_at: :desc)
    else
      @posts = Post.page(params[:page]).order(created_at: :desc)
    end
  end

  def popular
    if params[:category]
      @category = Category.find(params[:category])
      @posts = @category.posts.joins(:likes).group(:post_id).order('count(post_id) desc')
    else
      @posts = Post.joins(:likes).group(:post_id).order('count(post_id) desc')
    end
    @posts = @posts.page(params[:page]).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.url = @post.url[-11, 11] # Get the last 11 characters from the url
    if @post.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if !@post.nil?
      @post.destroy
      flash[:success] = '投稿を削除しました。'
    else
      flash[:danger] = '該当する投稿がありません。'
    end
    redirect_to current_user
  end

  private

  def post_params
    params.require(:post).permit(
      :url,
      :category_id,
      :content
    )
  end
end
