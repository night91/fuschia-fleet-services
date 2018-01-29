module Exceptions
  class InvalidCorporationLoginError < StandardError
    def initialize
      super('User corporation_id is invalid')
    end
  end
end