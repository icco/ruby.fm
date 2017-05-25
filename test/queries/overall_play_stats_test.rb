require "test_helper"

class OverallPlayStatsTest < ActiveSupport::TestCase
  test "it returns an array of stats" do
    channel = Fabricate(:channel)
    episode = Fabricate(:episode, channel: channel)

    dates = []
    10.times do |i|
      played_at = i.days.ago.to_date
      dates << played_at
      Fabricate(:play, episode: episode, bucket: played_at, total: i)
    end

    result = OverallPlayStats.new(channel).call

    assert_equal(10, result.count)

    assert_equal(9, result[0].total)
    assert_equal(Date.today - 9.days, result[0].date)

    assert_equal(8, result[1].total)
    assert_equal(Date.today - 8.days, result[1].date)

    assert_equal(7, result[2].total)
    assert_equal(Date.today - 7.days, result[2].date)
  end
end
