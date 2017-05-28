class Subscription
  def initialize(user)
    @user = user
  end

  def subscribe(plan_id)
    return true if @user.stripe_subscription_id.present?
    cu = @user.stripe_customer

    subscription = cu.subscriptions.create(plan: plan_id)

    @user.strip_subscription_id = subscription.id
    @user.plan_id = plan_id
    @user.save
  end

  def update_card(token)
    cu = @user.stripe_customer
    cu.source = token
    cu.save
  end

  def unsubscribe
    return true if @user.stripe_subscription_id.blank?

    su = @user.stripe_subscription
    su.delete

    @user.stripe_subscription_id = nil
    @user.stripe_plan_id = nil
    @user.save
  end
end
