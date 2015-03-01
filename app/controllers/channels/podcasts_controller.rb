module Channels
  class PodcastsController < ApplicationController
    before_action :set_channel

    def set_channel
      @channel = Channel.find_by!(slug: params[:channel_slug])
    end

    def podcast_params
      params.fetch(:podcast, {}).permit(:title, :notes, :published, :audio, :length)
    end

    def new
      @podcast = Podcast.new

      respond_to do |format|
        format.html
      end
    end

    # POST - /:channel_slug/new
    # @return [void]
    def create
      authorize(@channel, :update?)

      @podcast = Podcast.new(podcast_params)
      @podcast.channel_id = @channel.id

      respond_to do |format|
        if @podcast.save
          format.html do
            flash[:notice] = 'Podcast was successfully created.'
            redirect_to(channel_podcast_slug_path(@channel.slug, @podcast.slug))
          end
        else
          format.html do
            render(:new, status: 400)
          end
        end
      end
    end

    def index
      @podcasts = @channel.podcasts
      respond_to do |format|
        format.html
      end
    end

    def feed
      @podcasts = @channel.podcasts.published.order(:created_at)

      respond_to do |format|
        format.html
        format.xml
      end
    end

    def show
      @podcast = @channel.podcasts.find_by!(slug: params[:podcast_slug])
      respond_to do |format|
        format.html
      end
    end

    def podcast_params
      params.fetch(:podcast, {}).permit(:title, :notes, :published, :audio)
    end
  end
end
