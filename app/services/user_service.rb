class UserService
  def initialize(refresh_token)
    access_code = Auth::AuthenticationService.new.obtain_access_code(refresh_token)
    @esi_api = Api::EsiApiService.new(access_code)
    @character_id = Auth::AuthenticationService.new.verify_token(access_code)
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
    unless @character_contacts
      @character_contacts =  @esi_api.character_contacts(@character_id)
      @character_contacts.each do |contact|
        unless contact[:contact_type] == 'faction'
          contact[:info] = @esi_api.send(contact[:contact_type], contact[:contact_id])
        else
          contact[:info] = { name: contact[:corporation_id]}
        end
      end
    end
    @character_contacts
  end

  def character_mail(mail_id)
    @esi_api.character_mail(@character_id, mail_id)
  end

  def character_mails_list
    @mail_list = @esi_api.character_mail_list(@character_id) unless @mail_list
    @mail_list
  end

  def character_skills
    @skills = @esi_api.character_skills(@character_id) unless @skills
    @skills
  end

  def character_suspicious_items
    unless  @suspicious_items
      items = Asset.all
      page = 0
      s_items = []

      loop do
        assets = @esi_api.character_assets(@character_id, page)
        break if assets.empty?

        items.each do |item|
          assets.each do |asset|
            if item[:asset_id] == asset[:type_id]
              s_items << { item: item, quantity: asset[:quantity] }
            end
          end
        end

        page += 1
      end

      @suspicious_items = count_array_duplicates(s_items)
    end

    @suspicious_items
  end

  def corporation_info
    @corporation = @esi_api.corporation(@character[:corporation_id]) unless @corporation
    @corporation
  end

  def alliance_info
    @alliance = @esi_api.alliance(@character[:alliance_id]) unless @alliance
    @alliance
  end

  private

  def count_array_duplicates(array)
    result = []
    hash= Hash.new(0)
    array.each { |v| hash[v[:item][:name]] += v[:quantity] }
    hash.each {|k, v| result << { name: k, quantity: v } }
    result
  end
end