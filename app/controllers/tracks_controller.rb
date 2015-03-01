class TracksController < ApplicationController
  before_action :set_track, except: [:index, :new, :create]

  # The index page provides a list of recently modified and published tracks by
  # all users.
  def index
    @tracks = Track.published.order(updated_at: :desc)
    @your_tracks = current_user.tracks
    render(:index)
  end

  # For uploading new Tracks.
  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    @track.user = current_user

    if @track.save
      flash[:notice] = 'track was successfully created.'
      redirect_to(@track)
    else
      redirect(:new, status: 400)
    end
  end

  def show
  end

  def edit
    authorize(@track, :update?)
    # TODO: Just shows user can edit
    @shows = Show.all
    respond_to do |format|
      format.html
    end
  end

  def update
    authorize(@track, :update?)

    respond_to do |format|
      if @track.update(track_params)
        format.html do
          flash[:notice] = 'track was successfully updated.'
          redirect_to(@track)
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
    @track.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'track was successfully destroyed.'
        redirect_to("/tracks")
      end
    end
  end

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:title, :notes, :published, :audio, :length, :show_id)
  end
end
