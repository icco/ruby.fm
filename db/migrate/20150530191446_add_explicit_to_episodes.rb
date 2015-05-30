class AddExplicitToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :explicit, :boolean, null: false, default: false
  end
end
