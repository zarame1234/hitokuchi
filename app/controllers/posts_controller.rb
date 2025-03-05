class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])  
  end

  def edit
  end

  def desteoy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private 
    def post_params
      params.require(:post).permit(:shop_name, :body, :image)   
    end
end
