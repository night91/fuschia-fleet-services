module AccountSetup
  extend ActiveSupport::Concern

  included do
    def self.create_user_if_not_exist!(character_id, token, character)
      user = self.find_by(character_id: character_id)

      unless user
        user = self.create(
          user_id: SecureRandom.hex(25),
          name: character[:name],
          character_id: character_id,
          corporation_id: character[:corporation_id],
          alliance_id: character[:alliance_id],
          token: token
       )
      end

      user
    end
  end
end