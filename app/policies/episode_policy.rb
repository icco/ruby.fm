class EpisodePolicy < ApplicationPolicy
  def initialize(user, episode)
    @user = user
    @episode = episode
  end

  def create?
    @user.present? && @user.paying?
  end

  def read?
    @episode.published? || owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def owner?
    @user.present? && @episode.user_id == @user.id
  end
end
