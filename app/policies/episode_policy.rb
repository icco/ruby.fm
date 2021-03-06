class EpisodePolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope=Episode.unscoped)
      @user = user
      @scope = scope
    end

    def resolve
      if user
        scope.joins(:channel).where(channels: { user_id: user.id })
      else
        Episode.none
      end
    end
  end

  def initialize(user, episode)
    @user = user
    @episode = episode
  end

  def create?
    @user.present? && @user.paying?
  end

  def read?
    @episode.visible? || owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def owner?
    user.present? && ChannelPolicy.new(user, @episode.channel).owner?
  end
end
