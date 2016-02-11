class ChannelsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  rescue_from(ActiveRecord::RecordNotFound, with: :respond_with_not_found)

  def respond_with_not_found(error)
    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('channel.errors.not_found')
        redirect_to(root_url)
      end
      format.any { redirect_to(root_url) }
    end
  end

  def index
    @channels = Channel.published

    respond_to do |format|
      format.html
    end
  end

  def show
    @channel = Channel.friendly.find(params[:id])
    authorize(@channel, :read?)

    @episodes = []

    @channel.episodes.recent.each do |episode|
      if policy(episode).update? || policy(episode).read?
        @episodes << episode
      end
    end

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

  def stats
    @channel = primary_channel

    # TODO: Cache and make sure to filter by the channel_id
    data = Keen.count_unique("podcast.download", {
      interval: "daily",
      timeframe: "previous_30_days",
      target_property: 'ip.address',
      filters: [{
        property_name: "channel_id",
        operator: "eq",
        property_value: @channel.id
      }]
    })
    @labels = data.map {|date| Time.parse(date['timeframe']['start']).strftime("%b %d")}.to_json
    @data = data.map {|date| date['value']}.to_json

  end

  def itunes
    @channel = primary_channel
  end

  def update
    @channel = Channel.friendly.find(params[:id])
    authorize(@channel, :update?)

    parameters = channel_params

    if params[:channel][:categories]
      parameters[:categories] = Array(params[:channel][:categories])
    end

    respond_to do |format|
      if @channel.update(parameters)
        format.html do
          flash[:notice] = I18n.t('channel.update.successful')
          redirect_to(edit_channel_url(@channel.slug))
        end
      else
        format.html do
          flash[:alert] = I18n.t('channel.update.failed')
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
    params.fetch(:channel, {}).permit(
      :title,
      :author,
      :slug,
      :published,
      :website_url,
      :summary,
      :image,
      :image_cache,
      :airdate,
      :itunes_url
    )
  end
end
