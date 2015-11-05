class SetDefaultAiredAtDateToNow < ActiveRecord::Migration
  def up
    execute <<-SQL
ALTER TABLE episodes ALTER COLUMN aired_at SET DEFAULT now();
SQL

    execute <<-SQL
UPDATE episodes SET aired_at = created_at WHERE aired_at IS NULL
SQL
  end

  def down
    execute <<-SQL
ALTER TABLE episodes ALTER COLUMN aired_at SET DEFAULT NULL
SQL
  end
end
