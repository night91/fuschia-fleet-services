class UserService
  def initialize(refresh_token)
    access_code = ::Auth::AuthenticationService.new.obtain_access_code(refresh_token)
    @esi_api = ::EsiApiService.new(access_code)
    @character_id = ::Auth::AuthenticationService.new.verify_token(access_code)
    @character = @esi_api.character(@character_id)
  end

  def character_info
    @character
  end

  def character_wallet
    @wallet = @esi_api.character_wallet(@character_id) unless @wallet
    @wallet
  end

  def character_wallet_journal
    @wallet_journal = @esi_api.character_wallet_journal(@character_id) unless @wallet_journal
    @wallet_journal
  end

  def character_corporation_history
    unless @corporation_history
      @corporation_history = @esi_api.character_corporation_history(@character_id)
      @corporation_history.each do |corporation|
        corporation[:info] = @esi_api.corporation(corporation[:corporation_id])
      end
    end
    @corporation_history
  end

  def character_contacts
    @character_contacts =  @esi_api.character_contacts(@character_id) unless @character_contacts
    @character_contacts
  end

  def character_skills
    @skills = @esi_api.character_skills(@character_id) unless @skills
    @skills
  end

  def corporation_info
    @corporation = @esi_api.corporation(@character[:corporation_id]) unless @corporation
    @corporation
  end

  def alliance_info
    @alliance = @esi_api.alliance(@character[:alliance_id]) unless @alliance
    @alliance
  end
end