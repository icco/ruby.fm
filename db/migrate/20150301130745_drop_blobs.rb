class DropBlobs < ActiveRecord::Migration
  def change
    drop_table :blobs
  end
end
