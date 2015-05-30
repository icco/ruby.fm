class AddSummaryToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :summary, :text
  end
end
