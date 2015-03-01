class NukeOmniauthPromoteDevise < ActiveRecord::Migration
  def change
    drop_table :authorizations
    drop_table :identities
    drop_table :users

    create_table "users" do |t|
      t.string "email", null: false
      t.string "encrypted_password", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet "current_sign_in_ip"
      t.inet "last_sign_in_ip"
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.integer "failed_attempts", default: 0, null: false
      t.string "unlock_token"
      t.datetime "locked_at"
      t.timestamps
    end

    add_index "users", ["confirmation_token"], name: "users_confirmation_token_key", unique: true, using: :btree
    add_index "users", ["email"], name: "users_email_key", unique: true, using: :btree
    add_index "users", ["unlock_token"], name: "users_unlock_token_key", unique: true, using: :btree
  end
end
