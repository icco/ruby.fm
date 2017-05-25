require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyFm
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
    config.active_record.schema_format = :sql

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :minitest, fixture_replacement: :fabrication
      g.stylesheets     false
      g.javascripts     false
      g.fixture_replacement :fabrication, dir: "lib/fabricators"
    end

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address        => 'smtp.mandrillapp.com',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV['MANDRILL_USERNAME'],
      :password       => ENV['MANDRILL_PASSWORD'],
      :domain         => 'ruby.fm',
      :enable_starttls_auto => true
    }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_url_options = { host: 'ruby.fm' }


    # Use a different cache store in production.
    case ENV['CACHE_STORE']&.downcase
    when 'redis'
      config.cache_store = :redis_store
    else
      config.cache_store = :null_store
    end
  end
end
