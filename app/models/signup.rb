class Signup
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :password, :email, :full_name, :channel_name, :stripe_token

  validates :email, presence: true
  validates :password, presence: true
  validates :full_name, presence: true
  validates :channel_name, presence: true

  attr_reader :user, :channel

  def initialize(args={})
    args.each do |k, v|
      setter = "#{k}="
      self.send(setter, v) if self.respond_to?(setter)
    end
  end

  def save
    if valid?
      persist!
    else
      false
    end
  end

  def persist!
    result = false
    ActiveRecord::Base.transaction do
      user = User.new({
        email: email,
        password: password,
        password_confirmation: password
      })

      unless user.save
        user.errors[:email].each { |m| errors.add(:email, m) }
        user.errors[:password].each { |m| errors.add(:password, m) }
        raise(ActiveRecord::Rollback)
      end

      channel = Channel.new(title: channel_name, user_id: user.id, author: full_name)

      unless channel.save
        channel.errors[:title].each { |m| errors.add(:channel_name, m) }
        raise(ActiveRecord::Rollback)
      end

      @user = user
      @channel = channel
      result = true
    end

    result
  end
end
