class StatsController < AuthorizedController
  before_action :authenticate_user!

  def index
    @channel = primary_channel
    @episodes = @channel.episodes

    @episode_stats = fetch_plays_in_last_7_days(@channel)

    respond_to do |format|
      format.html
    end
  end


  def overall
    @channel = primary_channel

    @data = fetch_plays_last_30_days(@channel)

    respond_to do |format|
      format.json
    end
  end

  def fetch_plays_last_30_days(channel)
    Rails.cache.fetch("#{channel.id}/last-30-days", expires_in: 12.hours) do
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


  def fetch_plays_in_last_7_days(channel)
    Rails.cache.fetch("#{channel.id}/last-7-days", expires_in: 12.hours) do
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
        timeframe: "this_7_days"
      }).each do |data|
        hash[data['episode_id']] = data['result']
      end
      hash
    end
  end
end
