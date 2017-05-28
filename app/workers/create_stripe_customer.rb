class CreateStripeCustomer
  include Sidekiq::Worker

  def perform(user_id, token, plan_id)
    user = User.find(user_id)

    perform!(user, token, plan_id)

    cmd = CreateSubscription.new
    cmd.perform!(user, plan_id)
  end

  def perform!(user, token, plan_id)
    cu = Stripe::Customer.create({
      email: user.email,
      source: token
    })

    user.stripe_customer_id = cu.id
    user.save
  end
end
