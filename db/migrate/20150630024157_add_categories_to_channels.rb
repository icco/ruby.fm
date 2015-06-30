class AddCategoriesToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :categories, :text, array: true, default: []
  end
end
