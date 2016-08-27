class DropUpdateTriggers < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
DROP FUNCTION update_modified_column() CASCADE
SQL
  end

  def down
    execute <<-SQL
CREATE FUNCTION update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;
SQL

    execute <<-SQL
CREATE TRIGGER "update_users_updated_at"
  BEFORE UPDATE ON "users"
  FOR EACH ROW
  EXECUTE PROCEDURE update_modified_column()
SQL
    execute <<-SQL
CREATE TRIGGER "update_channels_updated_at"
  BEFORE UPDATE ON "channels"
  FOR EACH ROW
  EXECUTE PROCEDURE update_modified_column()
SQL
    execute <<-SQL
CREATE TRIGGER "update_episodes_updated_at"
  BEFORE UPDATE ON "episodes"
  FOR EACH ROW
  EXECUTE PROCEDURE update_modified_column()
SQL
  end
end
