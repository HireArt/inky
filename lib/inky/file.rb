require 'rest_client'
require 'addressable/uri'

module Inky
  class File
    METADATA_FIELDS = :md5, :mimetype, :uploaded, :container, :writeable,
                      :filename, :location, :key, :path, :size

    attr_accessor(*METADATA_FIELDS)
    attr_accessor :uid, :local_file, :remote_url, :metadata

    def initialize(value)
      if value.is_a?(File)
        self.local_file = value
      elsif valid_url?(value)
        self.remote_url = value
      else
        self.uid = value
        reload_file
      end
    end

  private

    def reload_file
      return unless uid
      response = RestClient.get "#{API_BASE_URL}/file/#{uid}/metadata"
      self.metadata = JSON.parse(response)
      METADATA_FIELDS.each do |f|
        send("#{f}=", metadata[f.to_s])
      end
    end

    def valid_url?(url)
      (parsed = Addressable::URI.parse(url)) && %w(http https).include?(parsed.scheme)
    rescue Addressable::URI::InvalidURIError
      false
    end
  end
end
