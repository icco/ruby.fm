class Subscription
  def initialize(user, options = {})
    @user = user
    @logger = options[:logger] || NullObject.new
  end

  def update_attributes(params = {})
    if customer_id.present?
      # we have them on file and just need to update the token as necessary
      if params[:token].present?
        return false unless update_customer(params[:token])
      end
    else
      # new customer
      if params[:token].present?
        return false unless create_customer(params[:token])
      end
    end

    if params[:plan_id].present? && customer_id.present?
      return false unless subscribe(params[:plan_id])
    end

    true
  end

  def subscription_id
    @user.stripe_subscription_id
  end

  def customer_id
    @user.stripe_customer_id
  end

  def update_customer(token)
    customer = Stripe::Customer.retrieve(customer_id)
    customer.description = @user.email
    customer.source = token
    customer.save
  end

  def create_customer(token)
    customer = Stripe::Customer.create(source: token, description: @user.email)
    @user.stripe_customer_id = customer.id
    @user.save
  end

  def subscribed?
    @user.stripe_subscription_id.present?
  end

  def subscribe(plan_id)
    # Update the user's plan
    @user.plan_id = plan_id

    if @user.stripe_subscription_id.present?
      subscription = Stripe::Subscription.retrieve(subscription_id)
      subscription.plan = plan_id
      subscription.save
    else
      # Create the subscription
      subscription = Stripe::Subscription.create(plan: plan_id, customer: customer_id)
      @user.stripe_subscription_id = subscription.id
    end

    # Save dat shit
    @user.save
  end

  def unsubscribe
    return true unless @user.stripe_subscription_id.present?

    subscription = Stripe::Subscription.retrieve(subscription_id)
    subscription.delete

    @user.stripe_subscription_id = nil
    @user.plan_id = nil
    @user.save

    true
  end
end
