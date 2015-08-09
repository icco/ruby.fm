module Channels
  class EpisodesController < ApplicationController
    # GET - /channels/{slug_or_id}/episodes/new
    def new
      @channel = Channel.friendly.find(params[:channel_id])
      authorize(@channel, :update?)

      @episode = @channel.episodes.build

      respond_to do |format|
        format.html
      end
    end

    # GET - /channels/{slug_or_id}/episodes
    def show
      @channel = Channel.friendly.find(params[:channel_id])
      @episode = @channel.episodes.friendly.find(params[:id])

      respond_to do |format|
        format.html
      end
    end

    # POST - /channels/{slug_or_id}/episodes
    def create
      @channel = Channel.friendly.find(params[:channel_id])
      authorize(@channel, :update?)


      @episode = Episode.new(episode_params)
      @episode.channel = @channel
      @episode.visible = true

      respond_to do |format|
        if @episode.save
          format.html { redirect_to(slugged_channel_episode_path(@channel.slug, @episode.slug)) }
        else
          puts @episode.errors.messages
          puts @episode.to_json
          format.html { render(action: :new, status: 400) }
        end
      end
    end

    def episode_params
      params.fetch(:episode, {}).permit(:title, :image, :image_cache, :notes, :audio, :length)
    end
  end
end
