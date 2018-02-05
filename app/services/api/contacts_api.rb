module Api
  module ContactsApi
    def character_contacts(character_id)
      get("#{@endpoint}/characters/#{character_id}/contacts/")
    end
  end
end