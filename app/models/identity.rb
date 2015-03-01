class Identity < OmniAuth::Identity::Models::ActiveRecord
  # A UID is actually an email address for identity, which is the name of the
  # omniauth provider for logging in with emails and passwords
  validates_uniqueness_of :uid
  validates_format_of :uid, :with => /@/
end
