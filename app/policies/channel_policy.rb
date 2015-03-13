class ChannelPolicy < ApplicationPolicy
  def initialize(user, channel)
    @user = user
    @channel = channel
  end

  def create?
    @user.present? && @user.paying?
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
    @user.present? && @channel.user_id == @user.id
  end
end
