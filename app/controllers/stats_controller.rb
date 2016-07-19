class StatsController < AuthorizedController
  before_action :authenticate_user!

  def index
    @channel = primary_channel
    @episodes = @channel.episodes

    @episode_stats = fetch_plays_grouped_by_episode(@channel)

    respond_to do |format|
      format.html
    end
  end

  def overall
    @channel = primary_channel

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

  def fetch_plays_grouped_by_episode(channel)
    Rails.cache.fetch("#{channel.id}/plays-grouped-by-episode", expires_in: 12.hours) do
      hash = {}
      Keen.count("podcast.download", {
        group_by: "episode_id",
        filters: [
          {
            property_name: "channel_id",
            operator: "eq",
            property_value: channel.id
          }
        ],
        timeframe: "previous_30_days"
      }).each do |data|
        hash[data['episode_id']] = data['result']
      end
      hash
    end
  end
end
