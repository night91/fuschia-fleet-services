require 'base64'
require 'rest-client'

module Auth
  class AuthenticationController < ApplicationController
    before_action :create_authentication_service

    def login
      redirect_to @authentication_service.cpplogin_endpoint
    end

    def logout
      destroy_session
      redirect_to root_path
    end

    def callback
      user = @authentication_service.process_cpplogin_callback(login_callback_params)
      user.update_roles
      create_session(user[:user_id])
      redirect_to root_path
    rescue ::Exceptions::InvalidCorporationLoginError => e
      Application.create(character_id: e.character_id, name: e.character_name, token: e.token, status: 'pending')
      redirect_to welcome_application_users_path
    end

    private

    def login_callback_params
      params.permit(:code, :state)
    end

    def create_authentication_service
      @authentication_service = AuthenticationService.new
    end
  end
end