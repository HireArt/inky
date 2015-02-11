require 'rest_client'
require 'addressable/uri'

module Inky
  class File
    METADATA_FIELDS = :md5, :mimetype, :uploaded, :container, :writeable,
                      :filename, :location, :key, :path, :size
    MF_ARGS = METADATA_FIELDS.each_with_object({}) { |f, h| h[f] = true }

    attr_accessor(*METADATA_FIELDS)
    attr_accessor :uid, :local_file, :remote_url, :metadata

    def initialize(value = nil)
      return unless value
      if value.is_a?(File)
        self.local_file = value
      elsif valid_url?(value)
        self.remote_url = value
      else
        self.uid = value
        request_metadata
      end
    end

  private

    def request_metadata
      return unless uid
      response = RestClient.get "#{API_BASE_URL}/file/#{uid}/metadata",
                                params: MF_ARGS
      self.metadata = JSON.parse(response)
      METADATA_FIELDS.each { |f| send("#{f}=", metadata[f.to_s]) }
    end

    def valid_url?(url)
      (parsed = Addressable::URI.parse(url)) &&
        %w(http https).include?(parsed.scheme)
    rescue Addressable::URI::InvalidURIError
      false
    end
  end
end
