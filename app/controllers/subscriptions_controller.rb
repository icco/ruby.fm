class SubscriptionsController < AuthorizedController
  def show
    @subscription = Subscription.new(current_user, logger: Rails.logger)

    respond_to do |format|
      format.html
    end
  end

  def update
    @subscription = Subscription.new(current_user, logger: Rails.logger)

    respond_to do |format|
      format.html { redirect(subscription_url) }
    end
  end
end
