# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150313022254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "channels", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",                      null: false
    t.string   "title",                        null: false
    t.string   "slug",                         null: false
    t.string   "link"
    t.string   "author"
    t.boolean  "published",  default: false,   null: false
    t.datetime "created_at", default: "now()", null: false
    t.datetime "updated_at", default: "now()", null: false
  end

  add_index "channels", ["slug"], name: "channels_slug_key", unique: true, using: :btree

  create_table "episodes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "channel_id",                   null: false
    t.string   "title",                        null: false
    t.datetime "airdate"
    t.text     "notes"
    t.string   "audio"
    t.integer  "length",     default: 0,       null: false
    t.string   "slug",                         null: false
    t.boolean  "visible",    default: true,    null: false
    t.datetime "created_at", default: "now()", null: false
    t.datetime "updated_at", default: "now()", null: false
  end

  add_index "episodes", ["channel_id", "slug"], name: "episodes_channel_id_slug_key", unique: true, using: :btree

  create_table "friendly_id_slugs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.uuid     "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,       null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",             default: "now()", null: false
    t.datetime "updated_at",             default: "now()", null: false
  end

  add_index "users", ["confirmation_token"], name: "users_confirmation_token_key", unique: true, using: :btree
  add_index "users", ["email"], name: "users_email_key", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "users_unlock_token_key", unique: true, using: :btree

  add_foreign_key "channels", "users", name: "channels_user_id_fkey"
  add_foreign_key "episodes", "channels", name: "episodes_channel_id_fkey"
end
