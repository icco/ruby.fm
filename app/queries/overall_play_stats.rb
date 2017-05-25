# Get the play stats for a given channel
#
# @example Basic usage
#   OverallPlayStats.new(Channel.first).call
class OverallPlayStats
  class Stat
    attr_reader :date, :total
    def initialize(date, total)
      @date  = date
      @total = total
    end
  end

  def initialize(channel)
    @channel = channel
  end

  def call
    Play.joins(:episode)
        .where(episodes: { channel_id: @channel.id })
        .where("bucket >= ?", 30.days.ago)
        .order(:bucket)
        .group(:bucket)
        .sum(:total)
        .map do |date, total|
          Stat.new(date, total)
        end
  end
end
