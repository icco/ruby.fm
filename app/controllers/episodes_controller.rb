class EpisodesController < ApplicationController
  def index
    @episodes = Episode.published.recent.includes(:channel)

    respond_to do |format|
      format.html
    end
  end

  # GET - /episodes/{id}/edit
  # @return [void]
  def edit
    @episode = Episode.find(params[:id])
    @channel = @episode.channel
    authorize(@channel, :update?)

    respond_to do |format|
      format.html
    end
  end

  def update
    @episode = Episode.find(params[:id])
    @channel = @episode.channel
    authorize(@channel, :update?)

    respond_to do |format|
      if @episode.update_attributes(episode_params)
        format.html { redirect_to(slugged_channel_episode_path(@channel.slug, @episode.slug)) }
      else
        format.html { render(action: :edit, status: 400) }
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html
    end
  end

  def episode_params
    params.fetch(:episode, {}).permit(:title, :notes, :visible, :length)
  end
end
