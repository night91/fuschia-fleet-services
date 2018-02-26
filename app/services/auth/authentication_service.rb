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
      character_id = verify_token(exchange_response[:access_token])

      process_user_login(character_id, exchange_response[:refresh_token])
    end

    def obtain_access_code(refresh_token)
      endpoint = @api_config['auth_endpoint'] + '/oauth/token'
      response = RestClient.post endpoint,
        obtain_access_code_params(refresh_token),
        { Authorization: encoded_authorization_header, 'X-User-Agent' => APP_CONFIG['api']['user-agent'] }
      JSON.parse(response.body, {:symbolize_names => true})[:access_token]
    end

    def verify_token(access_token)
      endpoint = @api_config['auth_endpoint'] + '/oauth/verify'
      response = RestClient.get endpoint,
                                { Authorization: authorization_header(access_token), 'X-User-Agent' => APP_CONFIG['api']['user-agent'] }
      JSON.parse(response.body, {:symbolize_names => true})[:CharacterID]
    end

    private

    def exchange_code(code)
      endpoint = @api_config['auth_endpoint'] + '/oauth/token'
      response = RestClient.post endpoint,
        exchange_code_params(code),
        { Authorization: encoded_authorization_header, 'X-User-Agent' => APP_CONFIG['api']['user-agent'] }
      JSON.parse(response.body, {:symbolize_names => true})
    end

    def process_user_login(character_id, token)
      character = character_info(character_id, token)
      User.create_user_if_not_exist!(character_id, token, character)
    end

    def character_info(character_id, token)
      character = ::Api::EsiApiService.new(token).character(character_id)
      fail Exceptions::InvalidCorporationLoginError.new(character_id,
                                                        character[:name],
                                                        character[:corporation_id],
                                                        character[:alliance_id],
                                                        token) unless check_character_corporation(character)
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

    def obtain_access_code_params(refresh_token)
      {
        grant_type: 'refresh_token',
        refresh_token: refresh_token
      }
    end

    def authorization_header(token)
      "Bearer #{token}"
    end

    def encoded_authorization_header
      encoded_auth = "#{@api_config['client_id']}:#{@api_config['secret_key'] || ENV['API_SECRET_KEY']}"
      encoded_auth = Base64.encode64(encoded_auth).delete("\n")
      "Basic #{encoded_auth}"
    end
  end
end