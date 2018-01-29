require 'base64'
require 'rest-client'

module Auth
  class AuthenticationService
    def initialize
      @api_config = APP_CONFIG['api']
    end

    def cpplogin_endpoint
      url = @api_config['auth_endpoint'] + '/oauth/authorize'
      params = {
        response_type: 'code',
        client_id: @api_config['client_id'],
        redirect_uri: @api_config['redirect_uri'],
        scope: @api_config['scope'],
        state: SecureRandom.hex(25),
        realm: APP_CONFIG['api']['realm']
      }
      url + '?' + params.to_query
    end

    def process_cpplogin_callback(params)
      exchange_response = exchange_code(params[:code])
      verification_response = verify_token(exchange_response[:access_token])

      response = {
        refresh_token: exchange_response[:refresh_token],
        character_id: verification_response[:CharacterID]
      }

      process_user_login(verification_response[:CharacterID], exchange_response[:refresh_token])
    end

    private

    def exchange_code(code)
      endpoint = @api_config['auth_endpoint'] + '/oauth/token'
      response = RestClient.post endpoint, exchange_code_params(code), { Authorization: encoded_authorization_header }
      JSON.parse(response.body, {:symbolize_names => true})
    end

    def verify_token(token)
      endpoint = @api_config['auth_endpoint'] + '/oauth/verify'
      response = RestClient.get endpoint, { Authorization: authorization_header(token) }
      JSON.parse(response.body, {:symbolize_names => true})
    end

    def process_user_login(character_id, token)
      character = character_info(character_id, token)
      User.create_user_if_not_exist!(character_id, token, character)
    end

    def character_info(character_id, token)
      character = EsiApiService.new(token).character(character_id)
      fail Exceptions::InvalidCorporationLoginError unless check_character_corporation(character)
      character
    end

    def check_character_corporation(character)
      character[:corporation_id] == APP_CONFIG['security']['corporation_id']
    end

    def exchange_code_params(code)
      {
        grant_type: 'authorization_code',
        code: code
      }
    end

    def authorization_header(token)
      "Bearer #{token}"
    end

    def encoded_authorization_header
      encoded_auth = "#{@api_config['client_id']}:#{@api_config['secret_key']}"
      encoded_auth = Base64.encode64(encoded_auth).delete("\n")
      "Basic #{encoded_auth}"
    end
  end
end