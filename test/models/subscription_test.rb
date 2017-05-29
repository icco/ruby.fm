require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  def user
    @user ||= Fabricate(:user)
  end

  def subscription
    @subscription ||= Subscription.new(user)
  end

  def test_subscription_id
    user.stripe_subscription_id = "abc123"
    assert_equal("abc123", subscription.subscription_id)
  end

  def test_customer_id
    user.stripe_customer_id = "abc123"
    assert_equal("abc123", subscription.customer_id)
  end

  def test_update_customer
    stripe_cus = mock("Stripe::Customer")
    stripe_cus.expects(:description=)
    stripe_cus.expects(:source=).with("abc123")
    stripe_cus.expects(:save)

    Stripe::Customer.expects(:retrieve).returns(stripe_cus)

    subscription.update_customer("abc123")
  end
end
