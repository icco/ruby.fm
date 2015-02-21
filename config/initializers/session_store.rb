# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_ruby_fm_session'
Rails.application.config.secret_token = ENV['SESSION_SECRET'] || 'fallback_token_for_development'
