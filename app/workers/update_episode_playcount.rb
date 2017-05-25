class UpdateEpisodePlaycount < ApplicationWorker
  def perform(episode_id)
    Episode.find(episode_id).update_play_count_cache
  end
end
