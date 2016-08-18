namespace :episodes do
  task update: [:environment] do
    Episode.all.find_each(batch_size: 100) do |e|
      UpdateEpisodePlaycount.perform_async(e.id)
    end
  end
end
