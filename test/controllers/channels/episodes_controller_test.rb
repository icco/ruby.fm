require 'test_helper'

module Channels
  class EpisodesControllerTest < ActionController::TestCase
    def setup
      @user = Fabricate(:user)
      @channel = Fabricate(:channel, user: @user)
    end

    def test_create_with_duplicate_title
      sign_in(@user)
      episode = Fabricate(:episode, channel: @channel)

      params = {
        channel_id: @channel.id,
        episode: {
          title: episode.title
        },
        format: 'html'
      }
      post(:create, params)

      assert_equal(302, response.status)
      assert_equal(2, @channel.episodes.count)
    end
  end
end
