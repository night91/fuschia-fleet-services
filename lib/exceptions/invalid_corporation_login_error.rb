module Exceptions
  class InvalidCorporationLoginError < StandardError
    attr_reader :character_id, :character_name, :corporation_id, :alliance_id, :token

    def initialize(character_id, character_name, corporation_id, alliance_id, token)
      @character_id = character_id
      @character_name = character_name
      @corporation_id = corporation_id
      @alliance_id = alliance_id
      @token = token

      super('User corporation_id is invalid')
    end
  end
end