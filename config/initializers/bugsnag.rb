Bugsnag.configure do |config|
  config.api_key = ENV["BUGSNAG_API_KEY"]
  config.release_stage = (ENV["BUGSNAG_RELEASE_STAGE"] || Rails.env)
  config.notify_release_stages = %w(production staging)
end
