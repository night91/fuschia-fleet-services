class EsiApiService
  def initialize(access_token)
    @endpoint = APP_CONFIG['api']['endpoint']
    @datasourse = APP_CONFIG['api']['datasourse']
    @access_token = access_token
  end

  def character(character_id)
    get("#{@endpoint}/characters/#{character_id}/", false)
  end

  def character_roles(character_id)
    get("#{@endpoint}/characters/#{character_id}/roles/")
  end

  def send_simple_mail(character_id, destination_character_id, subject, body)
    params = {
      recipients: [
        { recipient_type: 'character', recipient_id: destination_character_id }
      ],
      subject: subject,
      body: body
    }
    post("#{@endpoint}/characters/#{character_id}/mail/", params)
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
