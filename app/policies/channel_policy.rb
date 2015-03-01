class ChannelPolicy
  def initialize(user, channel)
    @user = user
    @channel = channel
  end

  def create?
    # later we'll need to check to see if they are paying or still within the
    # plan's limits
    true
  end

  def read?
    @channel.published? || owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def owner?
    @channel.user_id == @user.id
  end
end
