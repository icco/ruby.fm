class CreateUpdateTrigger < ActiveRecord::Migration
  def up
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
  end

  def down
    execute %Q{DROP FUNCTION update_modified_column}
  end
end
