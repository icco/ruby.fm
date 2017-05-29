class HomeController < ApplicationController
  def index
    @channel = Channel.find_by_slug('consolefm')

    if @channel
      @episodes = @channel.episodes.all.recent.limit(4)
    else
      @episodes = Episode.none
    end
  end

  def itunes
  end

  def about
  end
end
