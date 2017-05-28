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

    query = PlayStatsQuery.new(@channel)
    query.interval = 30

    @plays = query.call

    respond_to do |format|
      format.json
    end
  end
end
