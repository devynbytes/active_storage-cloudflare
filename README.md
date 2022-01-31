# ActiveStorage::Cloudflare

This gem adds the Cloudflare Images service as an ActiveStorage service. 

> Experimental at best. I'm not sure that active_storage is a good fit for the Cloudflare service. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_storage-cloudflare'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_storage-cloudflare

## Setup 

Add the `cloudflare_images` configuration in `config/storage.yml`

```yaml
cloudflare_images:
  service: CloudflareImages
  api_key: "cloudflare-api-key"            # The cloudflare api key (see api keys in images dashboard)
  account_id: "cloudflare-account-id"      # The cloudflare images account id (found in images dashboard)
  default_key: "cloudflare-default-key"    # Default key used for image signing (found in images dashboard) 
  require_signed_urls: false
  images_hash: "cloudflare-images-hash"    # The images hash used for the image delivery url (i.e. https://imagedelivery.net/<images-hash>/<image_id>/<variant_name>)
  adapter: Faraday.default_adapter         # By default, uses the default adapter for Faraday, but you can replace it with this config value. 
```

## Usage

### For an image url: 

```erb

Original file URL:

<%= image_tag @photo.image.url %>
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/devynbit/active_storage-cloudflare. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/devynbit/active_storage-cloudflare/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveStorage::Cloudflare project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/devynbit/active_storage-cloudflare/blob/main/CODE_OF_CONDUCT.md).
