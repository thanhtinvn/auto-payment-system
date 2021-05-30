require_relative "boot"

require "rails/all"
require 'dotenv/load'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    # Load file from lib folder
    config.paths.add 'lib', eager_load: true
    # Configuration for the application, engines, and railties goes here.
    config.time_zone = ENV['TIME_ZONE']
    config.active_record.default_timezone = :local
    config.paths.add 'services', eager_load: true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end if ENV['RAILS_ENV'] == 'development'
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.api_only = true
    config.paths.add 'services', eager_load: true
  end
end
