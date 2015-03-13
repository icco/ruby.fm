class TrackPolicy
  def initialize(user, track)
    @user = user
    @track = track
  end

  def create?
    # later we'll need to check to see if they are paying or still within the
    # plan's limits
    true
  end

  def read?
    @track.published? || owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def owner?
    @user.present? && @track.user_id == @user.id
  end
end
