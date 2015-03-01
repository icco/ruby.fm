class TracksController < ApplicationController
  before_action :set_track, except: [:index, :new]

  # The index page provides a list of recently modified and published tracks by
  # all users.
  def index
    @tracks = Track.published.order(updated_at: :desc)
    render(:index)
  end

  def edit
    authorize(@track, :update?)
    @channel = @track.channel

    respond_to do |format|
      format.html
    end
  end

  def update
    authorize(@track, :update?)
    @channel = @track.channel

    respond_to do |format|
      if @track.update(track_params)
        format.html do
          flash[:notice] = 'track was successfully updated.'
          redirect_to(channel_track_slug_path(@channel.slug, @track.slug))
        end
      else
        format.html do
          render(:edit, status: 400)
        end
      end
    end
  end

  # DELETE - /tracks/{id}
  # @return [void]
  def destroy
    authorize(@track, :destroy?)
    @channel = @track.channel
    @track.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'track was successfully destroyed.'
        redirect_to(channel_slug_path(@channel.slug))
      end
    end
  end

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:title, :notes, :published, :audio, :length)
  end
end
