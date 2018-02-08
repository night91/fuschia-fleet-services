module Api
  class EsiApiService
    include CharacterApi
    include AllianceApi
    include WalletApi
    include MailApi
    include SkillsApi
    include CorporationApi
    include ContactsApi
    include AssetsApi

    def initialize(access_token)
      @endpoint = APP_CONFIG['api']['endpoint']
      @datasourse = APP_CONFIG['api']['datasourse']
      @access_token = access_token
    end

    def get(endpoint, auth = true)
      response = RestClient.get endpoint, authorization_header(auth)
      process_response(response)
    end

    def post(endpoint, params, auth = true)
      response = RestClient.post endpoint, params.to_json, authorization_header(auth)
      puts response.inspect
      process_response(response)
    end

    private

    def process_response(response)
      JSON.parse(response.body, {:symbolize_names => true})
    rescue JSON::ParserError
      response.body
    end

    def authorization_header(auth = true)
      auth ? { Authorization: "Bearer #{@access_token}", 'Content-Type'=> 'application/json' ,'X-User-Agent' => APP_CONFIG['api']['user-agent'] } : {}
    end
  end
end