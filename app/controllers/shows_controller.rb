class ShowsController < ApplicationController
  before_action :set_show, except: [:index, :new, :create]

  # The index page provides a list of recently modified shows by all users.
  def index
    @shows = Show.all.order(updated_at: :desc)
    render(:index)
  end

  # For uploading new shows.
  def new
    @show = Show.new
  end

  def create
    @show = Show.new(show_params)

    if @show.save
      flash[:notice] = 'show was successfully created.'
      redirect_to(@show)
    else
      redirect(:new, status: 400)
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml
      # TODO: Why doesn't this work?
      format.rss { render :xml }
    end
  end

  def edit
    authorize(@show, :update?)
    respond_to do |format|
      format.html
    end
  end

  def update
    authorize(@show, :update?)
    respond_to do |format|
      if @show.update(show_params)
        format.html do
          flash[:notice] = 'show was successfully updated.'
          redirect_to(@show)
        end
      else
        format.html do
          render(:edit, status: 400)
        end
      end
    end
  end

  # DELETE - /shows/{id}
  # @return [void]
  def destroy
    authorize(@show, :destroy?)
    @show.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'show was successfully destroyed.'
        redirect_to("/shows")
      end
    end
  end

  def set_show
    @show = Show.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:name)
  end
end
