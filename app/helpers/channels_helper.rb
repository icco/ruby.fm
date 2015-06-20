module ChannelsHelper
  def episode_image_tag(episode, args={})
    imigix = args.slice(:width, :height, :fit).to_query
    url = "#{episode.image_url}?#{imigix}"
    args.delete(:fit)

    image_tag(url, args)
  end
end
