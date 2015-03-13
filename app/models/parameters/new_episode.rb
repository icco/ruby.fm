module Parameters
  class NewEpisode
    include Virtus.model(nullify_blank: true)

    attribute(:title, String)
    attribute(:channel, String)
  end
end
