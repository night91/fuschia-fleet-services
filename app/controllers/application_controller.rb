class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Auth::SessionsHelper
  include Pundit

  before_action :touch_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:warning] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def touch_session
    current_user
  end
end
