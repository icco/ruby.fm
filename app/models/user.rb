class User < ActiveRecord::Base
  has_many :authorizations

  # This method is fraught with all kinds of peril.
  def self.create_from_hash!(hash)
    name = "" || hash['user_info']['name']
    create(:name => name)
  end
end
