class StatsController < AuthorizedController
  before_action :authenticate_user!

  def index
    @channel = primary_channel
    @episodes = @channel.episodes.order('created_at DESC')
    @episode_plays = @channel.episodes.sum(:play_count)

    respond_to do |format|
      format.html
    end
  end

  def overall
    @channel = primary_channel

    # Only want the last 30 days worth of plays
    # TODO: We will probably need to zero fill for the days that no plays exist
    @plays = OverallPlayStats.new(@channel).call

    respond_to do |format|
      format.json
    end
  end
end
