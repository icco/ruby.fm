class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :title
      t.string :author
      t.datetime :airdate
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
