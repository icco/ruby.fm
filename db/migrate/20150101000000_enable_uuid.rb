class EnableUuid < ActiveRecord::Migration
  def up
    execute %Q{CREATE EXTENSION "uuid-ossp"}
  end

  def down
    execute %Q{DROP EXTENSION "uuid-ossp"}
  end
end
