class AddPlayCountToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :play_count, :integer, default: 0
  end
end
