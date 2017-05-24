require "test_helper"

class EpisodesTest < ActiveSupport::TestCase
  test "record play inrements the play count" do
    episode = Fabricate(:episode)

    episode.record_play(date: Date.new(2017, 1, 1))
    assert_equal(1, episode.play_count)
    assert_equal(1, episode.plays.count)

    episode.record_play(date: Date.new(2017, 1, 1))
    assert_equal(2, episode.play_count)
    assert_equal(1, episode.plays.count)
  end

  test "update play count cache functions properly" do
    episode = Fabricate(:episode)

    Fabricate(:play, episode: episode, bucket: Date.new(2017, 1, 1), total: 1)
    Fabricate(:play, episode: episode, bucket: Date.new(2017, 1, 2), total: 3)
    Fabricate(:play, episode: episode, bucket: Date.new(2017, 1, 3), total: 5)

    episode.update_play_count_cache

    assert_equal(9, episode.play_count)
  end
end
