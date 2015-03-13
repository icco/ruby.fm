class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from(Pundit::NotAuthorizedError, with: :access_denied)

  def access_denied(error=nil)
    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('errors.access_denied')
        redirect_to(root_url)
      end
    end
  end
end
