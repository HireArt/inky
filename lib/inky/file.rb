require 'rest_client'
require 'addressable/uri'

module Inky
  class File
    METADATA_FIELDS = :md5, :mimetype, :uploaded, :container, :writeable,
                      :filename, :location, :key, :path, :size, :width,
                      :height
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

    def url
      "#{BASE_URL}/file/#{uid}"
    end

    def save!(opts = {})
      opts = { location: 's3', key: Inky.api_key }.merge(opts)
      location = opts.delete(:location)
      post_url = Addressable::URI.parse("#{BASE_URL}/store/#{location}")
      post_url.query_values = opts
      puts post_url.to_s
      post_opts = { url: remote_url, fileUpload: local_file }
      post_opts = post_opts.delete_if { |_, v| v.nil? }
      response = RestClient.post post_url.to_s, post_opts
      self.uid = JSON.parse(response)['url'].split('/').last
      request_metadata
      self
    end

  private

    def request_metadata
      return unless uid
      response = RestClient.get "#{url}/metadata", params: MF_ARGS
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
