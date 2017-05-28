class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  has_many :channels, dependent: :destroy
  has_many :episodes, through: :channels

  before_destroy :unsubscribe_from_stripe

  # TODO: This is only temporary until we figure out some sort of billing
  #       structure
  def paying?
    true
  end

  def unsubscribe_from_stripe
    return if stripe_customer_id.blank?

    stripe_subscription.delete
  rescue
    Rails.logger.error { "[Stripe] could not unsubscribe #{self.stripe_customer_id} for user=#{self.id}" }
  end

  def current_admin
    current_user && current_user.is_admin
  end

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(self.stripe_customer_id)
  end

  def stripe_subscription
    @stripe_subscription ||= stripe_customer.subscriptions.retrieve(self.stripe_subscription_id)
  end
end
