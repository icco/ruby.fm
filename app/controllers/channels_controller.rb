class ChannelsController < ApplicationController
  def index
    @channels = Channel.published

    respond_to do |format|
      format.html
    end
  end

  def show
    @channel = Channel.friendly.find(params[:id])
    authorize(@channel, :read?)

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def edit
    @channel = Channel.friendly.find(params[:id])
    authorize(@channel, :update?)

    respond_to do |format|
      format.html
    end
  end

  def update
    @channel = Channel.friendly.find(params[:id])
    authorize(@channel, :update?)

    respond_to do |format|
      if @channel.update(channel_params)
        format.html do
          flash[:notice] = I18n.t('channel.update.successful')
          redirect_to(channel_url(@channel.slug))
        end
      else
        format.html do
          flash[:alert] = I18n.t('channel.update.successful')
          render(action: 'edit', status: 400)
        end
      end
    end
  end

  def destroy
    @channel = Channel.friendly.find(params[:id])
    authorize(@channel, :destroy?)

    respond_to do |format|
      if destroy_channel? && @channel.destroy
        format.html do
          flash[:notice] = I18n.t('channel.destroy.successful')
          redirect_to(channels_url)
        end
      else
        format.html do
          flash[:alert] = I18n.t('channel.destroy.failed')
          redirect_to(channel_url(@channel.slug))
        end
      end
    end
  end

  private

  def destroy_channel?
    current_user.channels.count > 1
  end

  def channel_params
    params.fetch(:channel, {}).permit(:title, :author, :slug, :published, :website_url)
  end
end
