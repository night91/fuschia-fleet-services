module Api
  module CharacterApi
    def character(character_id)
      get("#{@endpoint}/characters/#{character_id}/", false)
    end

    def character_roles(character_id)
      get("#{@endpoint}/characters/#{character_id}/roles/")
    end

    def character_corporation_history(character_id)
      get("#{@endpoint}/characters/#{character_id}/corporationhistory/")
    end
  end
end