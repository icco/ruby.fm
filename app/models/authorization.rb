class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # Given a login hash (example below), find a valid authorization.
  #
  # {"utf8"=>"✓",
  #  "authenticity_token"=>"bBvR1G6VMxGs+3bppidps1+ANTTjy9AnXPoDz7y3lK1uhvYx26zz7s2oyff+U778MmrND5ar4iCKC9dQ6tmEQA==",
  #  "name"=>"icco",
  #  "email"=>"nat@natwelch.com",
  #  "password"=>"[FILTERED]",
  #  "password_confirmation"=>"[FILTERED]",
  #  "commit"=>"Register",
  #  "provider"=>"identity"}
  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
  end
end
