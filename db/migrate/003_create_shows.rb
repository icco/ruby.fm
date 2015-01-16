class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :name
      t.timestamps
    end

    add_column :tracks, :show_id, :integer
  end

  def self.down
    drop_table :shows
    remove_column :tracks, :show_id
  end
end
