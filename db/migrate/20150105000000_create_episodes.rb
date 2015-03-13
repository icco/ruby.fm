class CreateEpisodes < ActiveRecord::Migration
  def up
    execute <<-SQL
CREATE TABLE "episodes" (
  "id"          UUID NOT NULL DEFAULT uuid_generate_v4(),
  "channel_id"  UUID NOT NULL REFERENCES channels("id"),
  "title"       CHARACTER VARYING NOT NULL,
  "airdate"     TIMESTAMP,
  "notes"       TEXT,
  "audio"       CHARACTER VARYING,
  "length"      INT NOT NULL DEFAULT 0,
  "slug"        CHARACTER VARYING NOT NULL,
  "visible"     BOOLEAN DEFAULT true NOT NULL,
  "created_at"  TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at"  TIMESTAMP NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  UNIQUE("channel_id", "slug")
)
SQL

    execute <<-SQL
CREATE TRIGGER "update_episodes_updated_at"
  BEFORE UPDATE ON "episodes"
  FOR EACH ROW
  EXECUTE PROCEDURE update_modified_column()
SQL
  end

  def down
    execute %Q{DROP TRIGGER "update_episodes_updated_at" ON "episodes"}
    execute %Q{DROP TABLE "episodes"}
  end
end
