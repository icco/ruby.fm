class AddExtensionToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :audio_ext, :string, default: 'mp3'
  end
end
