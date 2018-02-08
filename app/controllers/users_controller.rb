class UsersController < ApplicationController
  def index
    authorize User
    @users = User.all
  end

  def profile
    authorize User

    @user = current_user
    @user_service = UserService.new(@user.token)
  end

  def show
    @user = User.find(params[:id])

    authorize @user
    @user_service = UserService.new(@user.token)
  end

  def application
    authorize User
  end
end
