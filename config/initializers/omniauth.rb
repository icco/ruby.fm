Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO(icco): Add dropbox and twitter auth support
  provider :identity, :fields => [:email]
end
