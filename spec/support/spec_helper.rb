require 'bundler/setup'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'inky'
require 'vcr'
require 'securerandom'

API_BASE_URL = 'https://www.filepicker.io/api'

ENV['FILEPICKER_API_KEY'] ||= SecureRandom.hex

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<FP_API_KEY>') { ENV['FILEPICKER_API_KEY'] }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
