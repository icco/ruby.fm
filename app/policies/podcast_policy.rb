class PodcastPolicy
  def initialize(user, podcast)
    @user = user
    @podcast = podcast

    @channel_policy = ChannelPolicy.new(@user, @podcast.channel)
  end

  def create?
    @channel_policy.update?
  end

  def read?
    return true if @channel_policy.owner?
    @channel_policy.read? && @podcast.published?
  end

  def update?
    @channel_policy.update?
  end

  def destroy?
    @channel_policy.destroy?
  end
end
