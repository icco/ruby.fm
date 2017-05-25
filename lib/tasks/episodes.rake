namespace :episodes do
  task update: [:environment] do
    Episode.all.find_each(batch_size: 100) do |e|
      UpdateEpisodePlaycount.perform_async(e.id)
    end
  end

  task backfill: [:environment] do
    Channel.all.find_each(batch_size: 100) do |c|
      results = Keen.count("podcast.download", {
        group_by: "episode_id",
        filters: [
          {
            property_name: "channel_id",
            operator: "eq",
            property_value: c.id
          }
        ],
        interval: "daily",
        timeframe: "previous_90_days"
      })

      ActiveRecord::Base.transaction do
        results.each do |data|
          bucket = Time.parse(data["timeframe"]["start"]).to_date
          data["value"].each do |set|
            episode = Episode.find_by(id: set["episode_id"])
            next if episode.nil?
            Play.create(episode: episode, total: data["result"].to_i, bucket: bucket)
          end
        end
      end
    end
  end
end
