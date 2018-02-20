class MailsController < ApplicationController
  def show
    authorize EveMail

    @mail = UserService.new(current_user.token).character_mail(params[:id])
  end
end
