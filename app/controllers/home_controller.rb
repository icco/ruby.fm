class HomeController < ApplicationController
  # https://stackoverflow.com/questions/27495326/rare-error-about-missing-view-welcome-index-formats-image
  respond_to :html

  def index
    # https://stackoverflow.com/questions/27495326/rare-error-about-missing-view-welcome-index-formats-image
    respond_with()
  end

  def itunes
  end

  def about
  end
end
