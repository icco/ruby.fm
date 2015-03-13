module My
  class ChannelsController < AuthorizedController
    def index
      @channels = current_user.channels

      respond_to do |format|
        format.html
      end
    end
  end
end
