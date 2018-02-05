module Api
  module WalletApi
    def character_wallet(character_id)
      get("#{@endpoint}/characters/#{character_id}/wallet/")
    end

    def character_wallet_journal(character_id)
      get("#{@endpoint}/characters/#{character_id}/wallet/journal/")
    end
  end
end