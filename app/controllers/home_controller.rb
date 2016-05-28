class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to channel_path(primary_channel)
    end

    @channel = Channel.find_by_slug('consolefm')

    if @channel
      @episodes = @channel.episodes.all.recent.limit(12)
    else
      @episodes = Episode.none
    end
  end

  def itunes
  end

  def about
  end
end
