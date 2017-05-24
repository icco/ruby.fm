require "test_helper"

class PlayTest < ActiveSupport::TestCase
  test "increment increases total and saves" do
    play = Fabricate(:play)

    assert_equal(0, play.total)
    play.increment
    assert_equal(1, play.total)
    play.increment
    assert_equal(2, play.total)
  end
end
