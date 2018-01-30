class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Auth::SessionsHelper
  include Pundit

  before_action :load_current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def load_current_user
    @current_user = current_user
  end
end
