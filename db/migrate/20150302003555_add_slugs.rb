class AddSlugs < ActiveRecord::Migration
  def change
    add_column :tracks, :slug, :string
    add_column :shows, :slug, :string
  end
end
