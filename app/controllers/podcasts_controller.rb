class PodcastsController < ApplicationController
  before_action :set_podcast

  def edit
    authorize(@podcast, :update?)
    @channel = @podcast.channel

    respond_to do |format|
      format.html
    end
  end

  def update
    authorize(@podcast, :update?)
    @channel = @podcast.channel

    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html do
          flash[:notice] = 'Podcast was successfully updated.'
          redirect_to(channel_podcast_slug_path(@channel.slug, @podcast.slug))
        end
      else
        format.html do
          render(:edit, status: 400)
        end
      end
    end
  end

  # DELETE - /podcasts/{id}
  # @return [void]
  def destroy
    authorize(@podcast, :destroy?)
    @channel = @podcast.channel
    @podcast.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Podcast was successfully destroyed.'
        redirect_to(channel_slug_path(@channel.slug))
      end
    end
  end

  def set_podcast
    @podcast = Podcast.find(params[:id])
  end

  def podcast_params
    params.require(:podcast).permit(:title, :notes, :published, :audio, :length)
  end
end
