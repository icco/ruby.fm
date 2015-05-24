class ChannelsDefaultToPublished < ActiveRecord::Migration
  def up
    change_column_default(:channels, :published, true)
  end

  def down
    change_column_default(:channels, :published, false)
  end
end
