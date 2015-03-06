class AddAudioToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :audio, :string
    add_column :tracks, :published, :boolean, default: false, null: false
    add_column :tracks, :length, :integer, default: 0, null: false
  end
end
