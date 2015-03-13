module My
  class EpisodesController < AuthorizedController
    def index
      @episodes = current_user.episodes.recent.includes(:channel)

      respond_to do |format|
        format.html
      end
    end
  end
end
