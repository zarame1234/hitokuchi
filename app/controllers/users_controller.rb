class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User(user_params)
    @user.update
    redirect_to user_path(@user)
end

private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_imane)
end

def ensure_guest_user
  @user = User.find(params[:id])
  if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
  end
end 
end