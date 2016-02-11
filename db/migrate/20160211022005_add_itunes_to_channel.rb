class AddItunesToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :itunes_url, :string
  end
end
