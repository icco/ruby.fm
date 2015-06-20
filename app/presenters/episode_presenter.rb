class EpisodePresenter < Presenter
  def channel
    model.channel
  end

  def image_url
    if model.image_url
      model.image_url.sub('rubyfm-blobs.s3.amazonaws.com', 'rubyfm.imgix.net') + "?w=200&h=200&fit=crop"
    elsif model.channel.image_url
      model.channel.image_url.sub('rubyfm-blobs.s3.amazonaws.com', 'rubyfm.imgix.net') + "?w=200&h=200&fit=crop"
    else
      nil
    end
  end
end
