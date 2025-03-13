class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destro
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to new_user_registration_path
  end

private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_imane)
end

def is_matching_login_user
  user = User.find(params[:id]) 
  unless user.id == current_user.id
    redirect_to posts_path
  end
end

def ensure_guest_user
  @user = User.find(params[:id])
  if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
  end
end 
end