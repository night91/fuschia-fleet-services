require 'securerandom'

module Auth
  module SessionsHelper
    def current_user
      session = Session.find_by_session_id(cookies[:session_id])
      User.find_by(user_id: session&.user_id)
    end

    def destroy_session
      Session.delete(cookies[:session_id])
      cookies.delete(:session_id)
    end

    def create_session(user_id)
      session_id = SecureRandom.hex(25)
      Session.create(session_id: session_id, user_id: user_id)
      cookies[:session_id] = session_id
    end

    def is_authenticated?
      !current_user.nil?
    end
  end
end
