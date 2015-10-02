class ChannelPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope=Channel.unscoped)
      @user = user
      @scope = scope
    end

    def resolve
      if user
        scope.joins(:user).where('users.id = ?', user.id)
      else
        Channel.none
      end
    end
  end

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
