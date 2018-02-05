module Api
  module AllianceApi
    def alliance(alliance_id)
      get("#{@endpoint}/alliances/#{alliance_id}/", false)
    end
  end
end