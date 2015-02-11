require_relative 'inky/file'
require 'active_support/core_ext/module/attribute_accessors'

module Inky
  BASE_URL = 'https://www.filepicker.io/api'

  mattr_accessor :api_key

  def self.authorize!(api_key)
    self.api_key = api_key
  end
end
