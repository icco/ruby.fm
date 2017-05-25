class CreatePlays < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
CREATE TABLE "plays" (
  id UUID NOT NULL DEFAULT uuid_generate_v4(),
  bucket date NOT NULL,
  total integer DEFAULT 0 NOT NULL,
  episode_id uuid NOT NULL REFERENCES episodes(id),
  created_at timestamp without time zone NOT NULL DEFAULT now(),
  updated_at timestamp without time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE INDEX index_plays_on_episode_id ON plays USING btree (episode_id);

CREATE INDEX index_plays_on_bucket ON plays USING btree (bucket);
SQL
  end

  def down
    drop_table :plays
  end
end
