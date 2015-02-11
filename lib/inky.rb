module Inky

  attr_accessor :api_key

  def self.authorize!(api_key)
    self.api_key = api_key
  end

end
