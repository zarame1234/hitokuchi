class UsersController < ApplicationController
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
end