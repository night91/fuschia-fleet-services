class EsiApiService
  def initialize(token)
    @endpoint = APP_CONFIG['api']['endpoint']
    @datasourse = APP_CONFIG['api']['datasourse']
    @token = token
  end

  def character(character_id)
    get("#{@endpoint}/characters/#{character_id}/", false)
  end

  def get(endpoint, auth = true)
    response = RestClient.get endpoint, authorization_header(auth)
    process_response(response)
  end

  def post(endpoint, params, auth = true)
    response = RestClient.get endpoint, params, authorization_header(auth)
    process_response(response)
  end

  private

  def process_response(response)
    JSON.parse(response.body, {:symbolize_names => true})
  end

  def authorization_header(auth = true)
    auth ? { Authorization: "Bearer #{@token}" } : {}
  end
end

