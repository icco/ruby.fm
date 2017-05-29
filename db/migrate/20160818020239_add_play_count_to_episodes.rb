class AddPlayCountToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :play_count, :integer, default: 0
  end
end
