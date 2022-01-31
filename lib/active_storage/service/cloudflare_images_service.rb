# frozen_string_literal: true

require "cloudflare_dev"
require "active_storage/log_subscriber"
require "active_storage/downloader"
require "action_dispatch"
require "action_dispatch/http/content_disposition"

module ActiveStorage
  class Service::CloudflareImagesService < Service
    def initialize(**config)
      @config = config
    end

    # Cloudflare only allows a single http request on upload
    def upload(key, io, checksum: nil, **options)
      instrument :upload, key: key, checksum: checksum do
        cloudflare_client.images.upload(file: io, requireSignedUrls: @config.fetch("require_signed_urls"))
      end
    end

    # Update metadata for the file identified by +key+ in the service.
    # Override in subclasses only if the service needs to store specific
    # metadata that has to be updated upon identification.
    def update_metadata(key, **metadata)
    end

    def download(key)
      if block_given?
        instrument :streaming_download, key: key do
          cloudflare_client.images.download(file_id: key)
        end
      else
        instrument :download, key: key do
          cloudflare_client.images.download(file_id: key)
        end
      end
    end

    def download_chunk(key, range)
      raise NotImplementedError
      # instrument :download_chunk, key: key, range: range do
      #   cloudflare_client.images.download(file_id: key)
      # end
    end

    # Concatenate multiple files into a single "composed" file.
    def compose(source_keys, destination_key, filename: nil, content_type: nil, disposition: nil, custom_metadata: {})
      raise NotImplementedError
    end

    # Delete the file at the +key+.
    def delete(key)
      instrument :delete, key: key do
        cloudflare_client.images.delete(file_id: key)
      end
    end

    # Delete files at keys starting with the +prefix+.
    def delete_prefixed(prefix)
      instrument :delete_prefixed, key: prefix do
        cloudflare_client.images.delete(file_id: prefix)
      end
    end

    # Return +true+ if a file exists at the +key+.
    def exist?(key)
      instrument :exist, key: key do
        cloudflare_client.images.details(file_id: key).present?
      end
    end

    # Returns a signed, temporary URL that a direct upload file can be PUT to on the +key+.
    # The URL will be valid for the amount of seconds specified in +expires_in+.
    # You must also provide the +content_type+, +content_length+, and +checksum+ of the file
    # that will be uploaded. All these attributes will be validated by the service upon upload.
    def url_for_direct_upload(key, expires_in:, content_type:, content_length:, checksum:, custom_metadata: {})
      instrument :url, key: key do
        cloudflare_client.images.direct_upload_url(expiry: expires_in)
      end
    end

    # Returns a Hash of headers for +url_for_direct_upload+ requests.
    def headers_for_direct_upload(key, filename:, content_type:, content_length:, checksum:, custom_metadata: {})
      {}
    end

    def public?
      @public
    end

    private

    def private_url(key, expires_in:, filename:, disposition:, content_type:, **)
      cloudflare_client.images.signed_url(key, key: @config.fetch("default_key"), expiry_seconds: expires_in)
    end

    def public_url(key, **)
      cloudflare_client.images.public_url(key)
    end

    def custom_metadata_headers(metadata)
      raise NotImplementedError
    end

    def cloudflare_client
      CloudflareDev::Client.new(
        api_key: @config.fetch("api_key"),
        account_id: @config.fetch("account_id"),
        images_hash: @config.fetch("images_hash"),
        adapter: @config.fetch("adapter")
      )
    end
  end
end
