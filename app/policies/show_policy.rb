class ShowPolicy
  def initialize(user, show)
    @user = user
    @show = show
  end

  def create?
    # later we'll need to check to see if they are paying or still within the
    # plan's limits
    true
  end

  def read?
    @show.published? || owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def owner?
    @user.present? && @show.user_id == @user.id
  end
end
