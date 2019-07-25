require_relative 'boot'

# require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module GsanApi
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.load_path += Dir["config/locales/**/*.yml"]
    config.i18n.default_locale = "pt-BR"
    config.time_zone = 'Buenos Aires'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    config.i18n.available_locales = ["pt-BR"]

    config.autoload_paths << Rails.root.join('app/services')

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end

    config.filter_parameters += [:senha]
    config.active_job.queue_adapter = :sucker_punch
  end
end
