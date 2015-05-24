module My
  class EpisodesController < AuthorizedController
    def index
      @episodes = current_user.episodes.recent.includes(:channel).order(created_at: :desc)

      respond_to do |format|
        format.html
      end
    end
  end
end
