class EpisodesVisibleFalseByDefault < ActiveRecord::Migration
  def up
    execute <<-SQL
ALTER TABLE episodes ALTER COLUMN visible SET DEFAULT false
SQL
  end

  def down
    execute <<-SQL
ALTER TABLE episodes ALTER COLUMN visible SET DEFAULT true
SQL
  end
end
