class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    respond_to do |format|
      format.html do
        @posts = Post.page(params[:page])
      end
      format.json do
        @posts = Post.all
      end
    end
  end

  def show
    @post = Post.find(params[:id])  
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
     flash[:notice] = "更新に成功しました。"
     redirect_to user_path(@post.user_id)
    else 
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:notice] = "削除に成功しました。"
      redirect_to user_path(post.user_id)
    end
  end

  private 
  def post_params
    params.require(:post).permit(:shop_name, :body, :image, :address)   
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end
end
