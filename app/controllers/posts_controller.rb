class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user.id = current_user.id
    post.save
    redirect_to root_path
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def desteoy
  end

  private 
    def post_params
      params.require(:post).permit(:shop_name, :body, :image)   
    end
end
