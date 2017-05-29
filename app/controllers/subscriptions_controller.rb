class SubscriptionsController < AuthorizedController
  def show
    @subscription = Subscription.new(current_user, logger: Rails.logger)

    respond_to do |format|
      format.html
    end
  end

  def update
    @subscription = Subscription.new(current_user, logger: Rails.logger)

    if @subscription.update_attributes(subscription_params)
      flash[:notice] = I18n.t("subscription.update.successsful")
    end

    respond_to do |format|
      format.html { redirect(subscription_url) }
    end
  end

  def subscription_params
    params.require(:subscription).permit(:token, :plan_id)
  end
end
