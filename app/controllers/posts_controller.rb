class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to user_path(@post.user_id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])  
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
    post.destroy
    redirect_to user_path(post.user_id)
  end

  private 
  def post_params
    params.require(:post).permit(:shop_name, :body, :image)   
  end
end
