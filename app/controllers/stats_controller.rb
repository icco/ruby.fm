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
    @plays = Play.joins(:episodes)
                 .where(episodes: { channel_id: @channel.id })
                 .where("bucket >= ?", 30.days.ago)

    @data = fetch_plays_overall(@channel)

    respond_to do |format|
      format.json
    end
  end

  def fetch_plays_overall(channel)
    Rails.cache.fetch("#{channel.id}/plays-overall", expires_in: 12.hours) do
      Keen.count_unique("podcast.download", {
        interval: "daily",
        timeframe: "previous_30_days",
        target_property: 'ip.address',
        filters: [{
          property_name: "channel_id",
          operator: "eq",
          property_value: @channel.id
        }]
      })
    end
  end
end
