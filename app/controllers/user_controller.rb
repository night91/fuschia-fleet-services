class UserController < ApplicationController
  def profile
    authorize User

    @user = current_user
    @user_service = UserService.new(@user.token)
  end

  def application
    authorize User
  end
end
