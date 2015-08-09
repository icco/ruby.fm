require 'test_helper'

module EpisodesControllerTests
  class UpdateTests < ActionController::TestCase
    tests EpisodesController

    def setup
      @user = Fabricate(:user)
      @channel = Fabricate(:channel, user: @user)
      @episode = Fabricate(:episode, channel: @channel)
    end

    def test_valid_aired_at
      sign_in(@user)

      params = {
        id: @episode.id,
        episode: {
          aired_at: '2010-01-05'
        },
        format: 'html'
      }
      put(:update, params)

      assert_equal(302, response.status)

      @episode.reload
      date = @episode.aired_at
      refute_nil(date)
      assert_equal(2010, date.year)
      assert_equal(1, date.month)
      assert_equal(5, date.day)
    end

    def test_valid_aired_at_with_slashes
      sign_in(@user)

      params = {
        id: @episode.id,
        episode: {
          aired_at: '2010/01/01'
        },
        format: 'html'
      }
      put(:update, params)

      assert_equal(302, response.status)

      @episode.reload
      date = @episode.aired_at
      refute_nil(date)
      assert_equal(2010, date.year)
      assert_equal(1, date.month)
      assert_equal(1, date.day)
    end

    def test_invalid_aired_at
      sign_in(@user)

      params = {
        id: @episode.id,
        episode: {
          aired_at: 'yolo swag bag'
        },
        format: 'html'
      }
      put(:update, params)

      assert_equal(302, response.status)

      @episode.reload
      assert_nil(@episode.aired_at)
    end
  end
end
