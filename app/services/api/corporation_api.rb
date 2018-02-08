module Api
  module CorporationApi
    def corporation(coorporation_id)
      get("#{@endpoint}/corporations/#{coorporation_id}/", false) || { name: 'Not found' }
    end
  end
end