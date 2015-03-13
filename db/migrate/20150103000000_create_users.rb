class CreateUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
CREATE TABLE "users" (
  "id"                      UUID NOT NULL DEFAULT uuid_generate_v4(),
  "email"                   CHARACTER VARYING DEFAULT ''::CHARACTER VARYING NOT NULL,
  "encrypted_password"      CHARACTER VARYING DEFAULT ''::CHARACTER VARYING NOT NULL,
  "reset_password_token"    CHARACTER VARYING,
  "reset_password_sent_at"  TIMESTAMP WITHOUT TIME ZONE,
  "remember_created_at"     TIMESTAMP WITHOUT TIME ZONE,
  "sign_in_count"           INTEGER DEFAULT 0 NOT NULL,
  "current_sign_in_at"      TIMESTAMP WITHOUT TIME ZONE,
  "last_sign_in_at"         TIMESTAMP WITHOUT TIME ZONE,
  "current_sign_in_ip"      INET,
  "last_sign_in_ip"         INET,
  "confirmation_token"      CHARACTER VARYING,
  "confirmed_at"            TIMESTAMP WITHOUT TIME ZONE,
  "confirmation_sent_at"    TIMESTAMP WITHOUT TIME ZONE,
  "unconfirmed_email"       CHARACTER VARYING,
  "failed_attempts"         INTEGER DEFAULT 0 NOT NULL,
  "unlock_token"            CHARACTER VARYING,
  "locked_at"               TIMESTAMP WITHOUT TIME ZONE,
  "created_at"              TIMESTAMP NOT NULL DEFAULT now(),
  "updated_at"              TIMESTAMP NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  UNIQUE("email"),
  UNIQUE("confirmation_token"),
  UNIQUE("unlock_token")
)
SQL

    execute <<-SQL
CREATE TRIGGER "update_users_updated_at"
  BEFORE UPDATE ON "users"
  FOR EACH ROW
  EXECUTE PROCEDURE update_modified_column()
SQL
  end

  def down
    execute %Q{DROP TRIGGER "update_users_updated_at" ON "users"}
    execute %Q{DROP TABLE "users"}
  end
end
