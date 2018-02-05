class MailController < ApplicationController
  def show
    authorize Mail

    @mail = UserService.new(current_user.token).character_mail(params[:id])
  end
end
