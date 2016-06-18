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

ActiveRecord::Schema.define(version: 20160618113514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bans", force: :cascade do |t|
    t.string   "status",                 limit: 32
    t.integer  "added_by_message_id",    limit: 8
    t.integer  "removed_by_message_id",  limit: 8
    t.integer  "bangroup_id",            limit: 8
    t.string   "channel",                limit: 64
    t.string   "target_account",         limit: 32
    t.string   "target_mask",            limit: 255
    t.string   "ban_mask",               limit: 255
    t.string   "ban_mode",               limit: 32
    t.string   "human_duration",         limit: 255
    t.string   "redirect_to",            limit: 64
    t.string   "public_reason",          limit: 512
    t.string   "private_reason",         limit: 512
    t.datetime "banned_at"
    t.string   "banned_by_command",      limit: 32
    t.string   "banned_by_nick",         limit: 32
    t.string   "banned_by_account",      limit: 32
    t.string   "banned_by_mask",         limit: 255
    t.string   "banned_by_automatism",   limit: 32
    t.datetime "unbanned_at"
    t.string   "unbanned_by_nick",       limit: 32
    t.string   "unbanned_by_account",    limit: 32
    t.string   "unbanned_by_mask",       limit: 255
    t.boolean  "unbanned_by_expiration"
    t.datetime "expires_at"
    t.datetime "created_at",                         null: false
  end

  create_table "cheat_sheets", force: :cascade do |t|
    t.string   "category",    limit: 32,                       null: false
    t.text     "markup",                                       null: false
    t.string   "markup_type", limit: 255, default: "markdown", null: false
    t.text     "html",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facts", force: :cascade do |t|
    t.integer  "target_fact_id"
    t.text     "name"
    t.text     "text"
    t.integer  "usage_count",                  default: 0
    t.string   "added_by_mask",    limit: 32
    t.string   "added_by_account", limit: 255
    t.datetime "updated_at"
  end

  create_table "frequently_asked_questions", force: :cascade do |t|
    t.string   "topic"
    t.integer  "position"
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "frequently_asked_questions", ["topic"], name: "index_frequently_asked_questions_on_topic", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "dialog_id",       limit: 8
    t.datetime "time",                        null: false
    t.integer  "source",          limit: 2,   null: false
    t.binary   "raw",                         null: false
    t.text     "sanitized"
    t.text     "html"
    t.jsonb    "json"
    t.string   "command",         limit: 32
    t.text     "body"
    t.string   "channel",         limit: 64
    t.string   "from_nick",       limit: 32
    t.string   "from_username",   limit: 255
    t.string   "from_host",       limit: 255
    t.string   "from_realname",   limit: 255
    t.string   "from_account",    limit: 32
    t.string   "to_nick",         limit: 32
    t.string   "to_username",     limit: 255
    t.string   "to_host",         limit: 255
    t.string   "to_realname",     limit: 255
    t.string   "to_account",      limit: 32
    t.jsonb    "mentioned_users"
  end

  create_table "paste_service_offenders", force: :cascade do |t|
    t.string   "nick",         limit: 32
    t.string   "mask",         limit: 32
    t.string   "account",      limit: 255
    t.text     "service"
    t.datetime "last_used_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "github",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["github"], name: "index_users_on_github", unique: true, using: :btree

  add_foreign_key "facts", "facts", column: "target_fact_id", name: "facts_target_fact_id_fkey", on_delete: :cascade
end
