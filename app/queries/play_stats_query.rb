class PlayStatsQuery
  # A small tuple that represents the stats
  class Stat
    attr_accessor :date, :total
    def initialize(date, total)
      @date = date
      @total = total
    end
  end

  attr_writer :interval

  # @param channel [Channel]
  def initialize(channel)
    @channel = channel
    @interval = 30
  end

  def call
    query = <<-SQL
WITH day_range AS (
  SELECT
    buckets.buckets::date AS bucket
  FROM generate_series(
    date_trunc('day', now()) - interval '#{@interval - 1} days',
    date_trunc('day', now()),
    '1 day'
  ) as buckets
)
SELECT
  day_range.bucket AS bucket,
  coalesce((SELECT
    SUM(plays.total) AS total
    FROM plays
    INNER JOIN episodes ON episodes.id = plays.episode_id
      AND episodes.channel_id = '#{@channel.id.to_s}'
    WHERE plays.bucket = day_range.bucket), 0) AS total
FROM day_range
GROUP BY day_range.bucket
ORDER BY day_range.bucket ASC
SQL

    ActiveRecord::Base.connection.execute(query).map do |row|
      Stat.new(Time.parse(row["bucket"]), row["total"])
    end
  end
end
