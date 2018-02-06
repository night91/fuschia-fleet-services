module Exceptions
  class InvalidCorporationLoginError < StandardError
    attr_reader :character_id, :character_name, :token

    def initialize(character_id, character_name, token)
      @character_id = character_id
      @character_name = character_name
      @token = token

      super('User corporation_id is invalid')
    end
  end
end