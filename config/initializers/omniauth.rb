Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO(icco): Add dropbox and twitter auth support
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
