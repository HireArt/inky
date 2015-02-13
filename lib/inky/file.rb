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
      self.uid = value
      request_metadata
    end

    def self.from_file(local_file)
      file = new
      file.local_file = local_file
      file
    end

    def self.from_url(url)
      file = new
      file.remote_url = url
      file
    end

    def uploaded_at
      Time.at(uploaded / 1000.0)
    end

    def url
      "#{BASE_URL}/file/#{uid}"
    end

    def save!(opts = {})
      opts = { location: 's3', key: Inky.api_key }.merge(opts)
      opts.merge filename: ::File.basename(local_file) if local_file
      handle_post_response RestClient.post(post_url(opts), post_opts)
      self
    end

  private

    def post_url(opts)
      location = opts.delete(:location)
      post_url = Addressable::URI.parse(uid ? url : store_url(location))
      post_url.query_values = opts
      post_url.to_s
    end

    def post_opts
      { url: remote_url, fileUpload: local_file }.delete_if { |_, v| v.nil? }
    end

    def handle_post_response(response)
      self.uid = JSON.parse(response)['url'].split('/').last
      request_metadata
      self.remote_url = self.local_file = nil
    end

    def store_url(location)
      "#{BASE_URL}/store/#{location}"
    end

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
