require_relative 'inky/file'

module Inky
  API_BASE_URL = 'https://www.filepicker.io/api/'

  attr_accessor :api_key

  def self.authorize!(api_key)
    self.api_key = api_key
  end
end
