require 'spec_helper'

describe 'Create Channel and Episode' do
  include DatabaseHelpers
  it 'works' do
    truncate(:friendly_id_slugs)
    truncate(:episodes)
    truncate(:channels)
    truncate(:users)

    user = Fabricate(:user)
    assert(user.persisted?)

    channel = Channel.create!(title: "Hey hey let's go", user_id: user.id)
    assert(channel.persisted?)
    assert_equal('hey-hey-let-s-go', channel.slug)

    episode = Episode.create!(title: "Kick ass too", channel_id: channel.id)
    assert(episode.persisted?)
    assert_equal('kick-ass-too', episode.slug)

    # Check duplicate channel case
    channel = Channel.create!(title: "Hey hey let's go", user_id: user.id)
    assert(channel.persisted?)
    assert_equal('hey-hey-let-s-go-2', channel.slug)

    episode = Episode.create!(title: "Kick ass too", channel_id: channel.id)
    assert(episode.persisted?)
    assert_equal('kick-ass-too', episode.slug)
  end
end
