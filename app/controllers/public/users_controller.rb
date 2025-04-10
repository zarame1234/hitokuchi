class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to new_user_registration_path
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end
  
  def followers
    user = User.find(params[:id])
    @user = user.follower_users
  end

  def favorites
    @user = User.find(params[:id])
    @favorite_posts = @user.favorited_posts
  end

private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end

def is_matching_login_user
  user = User.find(params[:id]) 
  unless user.id == current_user.id
    redirect_to user_path(current_user)
  end
end

def ensure_guest_user
  @user = User.find(params[:id])
  if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
  end
end 


end