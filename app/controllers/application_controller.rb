class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Auth::SessionsHelper

  before_action :load_current_user

  private

  def load_current_user
    @current_user = current_user
  end
end
