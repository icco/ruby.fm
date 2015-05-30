class AddWebsiteUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :website_url, :string
  end
end
