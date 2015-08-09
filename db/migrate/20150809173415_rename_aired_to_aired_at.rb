class RenameAiredToAiredAt < ActiveRecord::Migration
  def change
    rename_column :episodes, :airdate, :aired_at
  end
end
