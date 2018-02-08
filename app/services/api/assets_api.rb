module Api
  module AssetsApi
    def character_assets(character_id, page = 0)
      get("#{@endpoint}/characters/#{character_id}/assets/?page=#{page}")
    end
  end
end