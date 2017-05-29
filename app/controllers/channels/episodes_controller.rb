module Channels
  class EpisodesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    # GET - /channels/{slug_or_id}/episodes/new
    def new
      @channel = Channel.friendly.find(params[:channel_id])
      authorize(@channel, :update?)

      @episode = @channel.episodes.build

      @uploader = @episode.audio.s3_post

      respond_to do |format|
        format.html
        format.json
      end
    end

    # GET - /channels/{slug_or_id}/episodes
    def show
      @channel = Channel.friendly.find(params[:channel_id])
      @episode = @channel.episodes.friendly.find(params[:id])
      authorize(@episode, :read?)

      respond_to do |format|
        format.html
        # JPEG or PNG, RGB color space, minimum size of 1400 x 1400 pixels and
        # a maximum size of 2048 x 2048 pixels
        # https://www.apple.com/itunes/podcasts/specs.html#image
        format.jpg {
          image_url = Imgix.client.path(@episode.image.s3_path).q(80).fm('jpg').fit('crop').width(2048).height(2048).to_url
          response.headers['Cache-Control'] = "public, max-age=#{84.hours.to_i}"
          response.headers['Content-Type'] = 'image/png'
          response.headers['Content-Disposition'] = 'inline'
          render :text => open(image_url, "rb").read
        }
      end
    end

    # POST - /channels/{slug_or_id}/episodes
    def create
      render text: params
      return

      @channel = Channel.friendly.find(params[:channel_id])
      authorize(@channel, :update?)

      @episode = Episode.new(episode_params)
      @episode.channel = @channel
      @episode.visible = false

      respond_to do |format|
        if @episode.save
          format.html { redirect_to(edit_episode_url(@episode.id)) }
          format.json { render json: @episode }
        else
          format.html { render(action: :new, status: 400) }
        end
      end
    end

    def episode_params
      params.fetch(:episode, {}).permit(:title, :image, :image_cache, :notes, :audio, :length)
    end
  end
end
