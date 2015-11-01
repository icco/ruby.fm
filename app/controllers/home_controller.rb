class HomeController < ApplicationController
  # https://stackoverflow.com/questions/27495326/rare-error-about-missing-view-welcome-index-formats-image
  respond_to :html

  def index
    @channel = Channel.find_by_slug('consolefm')
    if @channel
      @episodes = @channel.episodes.all.order("title DESC").limit(12)
    else
      @episodes = Episode.none
    end
    # https://stackoverflow.com/questions/27495326/rare-error-about-missing-view-welcome-index-formats-image
    respond_with()
  end

  def itunes
  end

  def about
  end
end
