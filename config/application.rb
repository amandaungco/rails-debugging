require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module Bridgetroll
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # set default from address across
    ActionMailer::Base.default from: 'Bridge Troll <troll@railsbridge.org>'

    # Devise emails use our layout
    config.to_prepare do
      Devise::Mailer.layout "mailer"
    end

    # allow cross origin requests from BridgeFoundry
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins 'bridgefoundry.org'
        resource '/events.json', headers: :any, methods: [:get]
      end
    end
  end
end
