class SubscriptionsController < AuthorizedController
  def show
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      format.html { redirect(subscription_url) }
    end
  end
end
