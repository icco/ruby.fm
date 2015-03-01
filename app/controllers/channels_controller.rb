class ChannelsController < ApplicationController
  before_action(:set_channel, only: [:show, :edit, :update, :destroy])

  before_action(:authenticate_user!, only: [:edit, :update, :destroy, :create, :new])

  # GET - /channels
  # @return [void]
  def index
    @channels = Channel.all

    respond_to do |format|
      format.html
    end
  end

  # GET - /channels/{id}/feed
  def feed
    @podcasts = @channel.podcasts.published

    respond_to do |format|
      format.html
      format.xml
    end
  end

  # GET - /channels/new
  # @return [void]
  def new
    @channel = Channel.new

    respond_to do |format|
      format.html
    end
  end

  # GET - /channels/{id}/edit
  # @return [void]
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST - /channels
  # @return [void]
  def create
    @channel = Channel.new(channel_params)
    @channel.user = current_user

    respond_to do |format|
      if @channel.save
        format.html do
          flash[:notice] = 'Channel was successfully created.'
          redirect_to(channel_slug_url(@channel.slug))
        end
      else
        format.html do
          render(:new, status: 400)
        end
      end
    end
  end

  # PUT,PATCH - /channels/{id}
  # @return [void]
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html do
          flash[:notice] = 'Channel was successfully updated.'
          redirect_to(channel_slug_url(@channel.slug))
        end
      else
        format.html do
          render(:edit, status: 400)
        end
      end
    end
  end

  # DELETE - /channels/{id}
  # @return [void]
  def destroy
    @channel.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = 'Channel was successfully destroyed.'
        redirect_to(channels_url)
      end
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.fetch(:channel, {}).permit(:title, :link, :author)
  end
end
