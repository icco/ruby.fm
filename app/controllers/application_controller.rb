class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  if Rails.env.production?
    rescue_from(Pundit::NotAuthorizedError, with: :access_denied)
    rescue_from(Pundit::NotDefinedError, with: :server_error)
    rescue_from(ActionController::UnknownFormat, with: :unknown_format)
  end

  def primary_channel
    if user_signed_in?
      current_user.channels.first
    else
      nil
    end
  end

  helper_method :primary_channel

  def unknown_format(error=nil)
    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('errors.unknown_format')
        redirect_to(root_url)
      end
      format.any { redirect_to(root_url) }
    end
  end

  def server_error(error=nil)
    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('errors.server_error')
        redirect_to(root_url)
      end
      format.any { redirect_to(root_url) }
    end
  end

  def access_denied(error=nil)
    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('errors.access_denied')
        redirect_to(root_url)
      end
      format.any { redirect_to(root_url) }
    end
  end
end
