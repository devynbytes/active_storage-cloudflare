# frozen_string_literal: true

require_relative "lib/active_storage/cloudflare/version"

Gem::Specification.new do |spec|
  spec.name = "active_storage-cloudflare"
  spec.version = ActiveStorage::Cloudflare::VERSION
  spec.authors = ["devynbit"]
  spec.email = ["devynbit@users.noreply.github.com"]

  spec.summary = "ActiveStorage service for Cloudflare Images"
  spec.description = "Adds the ability to use ActiveStorage with the Cloudflare Images service"
  spec.homepage = "https://github.com/devynbit/active_storage-cloudflare"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/devynbit/active_storage-cloudflare.git"
  spec.metadata["changelog_uri"] = "https://github.com/devynbit/active_storage-cloudflare/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rails", ">= 6.0.0"
  spec.add_dependency "cloudflare_dev", "~> 0.1.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
