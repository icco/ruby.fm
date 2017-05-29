class CreateSubscription
  def perform(user_id, plan_id)
    perform!(User.find(user_id), plan_id)
  end

  def perform!(user, plan_id)
    cu = user.stripe_customer
    subscription = cu.subscriptions.create(plan: plan_id)

    user.stripe_subscription_id = subscription.id
    user.plan_id = plan_id
    user.save
  end
end
