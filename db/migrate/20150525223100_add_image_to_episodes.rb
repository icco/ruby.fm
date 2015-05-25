class AddImageToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :image, :string
  end
end
