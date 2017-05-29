json.data do
  json.id(@episode.id.to_s)
  json.type("episodes")

  json.attributes do
    json.title(@episode.title)
    json.slug(@episode.slug)
    json.explicit(@episode.explicit)
    json.play_count(@episode.play_count)

    json.aired_at(@episode.aired_at&.iso8601)
    json.updated_at(@episode.updated_at&.iso8601)
    json.created_at(@episode.created_at&.iso8601)
  end

  json.relationships do
    json.channel do
      json.data do
        json.type("channels")
        json.id(@episode.channel_id.to_s)
      end
    end
  end

  json.links do
    json.set!(:self, episode_url(@episode.id))
  end
end
