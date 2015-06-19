class AddCoverArtToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :image, :json, default: {}
  end
end
