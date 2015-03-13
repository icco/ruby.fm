class CreateChannels < ActiveRecord::Migration
  def up
    execute <<-SQL
CREATE TABLE "channels" (
  "id"          UUID NOT NULL DEFAULT uuid_generate_v4(),
  "user_id"     UUID NOT NULL REFERENCES users("id"),
  "title"       CHARACTER VARYING NOT NULL,
  "slug"        CHARACTER VARYING NOT NULL,
  "link"        CHARACTER VARYING,
  "author"      CHARACTER VARYING,
  "visible"     BOOLEAN DEFAULT true NOT NULL,
  "created_at"  TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at"  TIMESTAMP NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  UNIQUE("slug")
)
SQL

    execute <<-SQL
CREATE TRIGGER "update_channels_updated_at"
  BEFORE UPDATE ON "channels"
  FOR EACH ROW
  EXECUTE PROCEDURE update_modified_column()
SQL
  end

  def down
    execute %Q{DROP TRIGGER "update_channels_updated_at" ON "channels"}
    execute %Q{DROP TABLE "channels"}
  end
end
