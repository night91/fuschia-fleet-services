require 'securerandom'

module Auth
  module SessionsHelper
    def current_user
      session = Session.find_by_session_id(cookies[:session_id])
      return nil unless session
      User.find_by(user_id: session.user_id) unless session_expired?(session)
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

    private
    def session_expired?(session)
      if Time.now - APP_CONFIG['session']['expiration_time'].to_f > session.created_at
        destroy_session
        return true
      end
      false
    end
  end
end
