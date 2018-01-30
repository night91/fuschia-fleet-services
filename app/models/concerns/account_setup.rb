module AccountSetup
  extend ActiveSupport::Concern

  def has_role!(role)
    return if has_role?(role)
    self.roles.create(name: role)
  end

  def has_role?(role)
    self.roles.exists?(name: role)
  end

  def update_roles
    access_token = Auth::AuthenticationService.new.obtain_access_code(self[:token])
    roles = EsiApiService.new(access_token).character_roles(self[:character_id])

    ActiveRecord::Base.transaction do
      self.roles.clear
      roles[:roles].each { |role| self.has_role!(role) }
    end
  end

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
      else
        user.update_attributes!(token: token)
      end

      user
    end
  end
end