class EpisodesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  before_action :fetch_episode, only: [:edit, :update, :show, :destroy]

  def index
    @episodes = Episode.published.recent.includes(:channel).order(created_at: :desc)

    respond_to do |format|
      format.html
    end
  end

  # GET - /episodes/{id}/edit
  # @return [void]
  def edit
    @channel = @episode.channel
    authorize(@channel, :update?)

    respond_to do |format|
      format.html
    end
  end

  def update
    @channel = @episode.channel
    authorize(@channel, :update?)

    filtered_params = episode_params

    if filtered_params[:aired_at]
      filtered_params[:aired_at] = Timeliness.parse(filtered_params[:aired_at], :datetime)
    end

    respond_to do |format|
      if @episode.update_attributes(filtered_params)
        format.html { redirect_to(slugged_channel_episode_path(@channel.slug, @episode.slug)) }
      else
        format.html { render(action: :edit, status: 400) }
      end
    end
  end

  def destroy
    @channel = @episode.channel

    @episode.destroy

    respond_to do |format|
      format.html { redirect_to(slugged_channel_url(@channel.slug)) }
      format.json { head(204) }
    end
  end

  # GET - /episodes/:id/play
  #
  # @return [void]
  def play
    @episode = Episode.find(params[:id])
    attributes = {
      keen: {
        timestamp: DateTime.now.utc.iso8601
      },
      episode_id: @episode.id,
      channel_id: @episode.channel_id,
      ip: request.remote_ip,
      ua_string: request.headers['User-Agent'],
      source: 'RubyFM'
    }
    KeenPublisher.perform_async('podcast.download', attributes)

    redirect_to(@episode.https_audio_url, status: 302)
  end

  # GET - /episodes/:id/download
  #
  # @return [void]
  def download
    @episode = Episode.find(params[:id])
    attributes = {
      keen: {
        timestamp: DateTime.now.utc.iso8601
      },
      episode_id: @episode.id,
      channel_id: @episode.channel_id,
      ip: request.remote_ip,
      ua_string: request.headers['User-Agent'],
      source: 'Other'
    }
    KeenPublisher.perform_async('podcast.download', attributes)

    redirect_to(@episode.https_audio_url, status: 302)
  end

  def find_episode(id)
    policy_scope(Episode).includes(:channel).friendly.find(id)
  end

  def fetch_episode
    @episode = find_episode(params[:id])
  end

  def episode_params
    params.fetch(:episode, {}).permit(:title, :image, :image_cache, :notes, :visible, :length, :explicit, :aired_at)
  end
end
