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

ActiveRecord::Schema.define(version: 20151125160221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "dialog_id",    limit: 8
    t.datetime "time",                     null: false
    t.integer  "source",       limit: 2,   null: false
    t.binary   "raw",                      null: false
    t.text     "sanitized"
    t.text     "html"
    t.jsonb    "json"
    t.string   "command",      limit: 32
    t.text     "body"
    t.string   "channel",      limit: 32
    t.string   "from_nick",    limit: 32
    t.string   "from_account", limit: 32
    t.string   "from_mask",    limit: 255
    t.string   "to_nick",      limit: 32
    t.string   "to_account",   limit: 32
    t.string   "to_mask",      limit: 255
    t.string   "nicks",                                 array: true
    t.string   "accounts",                              array: true
  end

  create_table "paste_service_offenders", force: :cascade do |t|
    t.string   "nick",         limit: 32
    t.string   "mask",         limit: 32
    t.string   "account",      limit: 255
    t.text     "service"
    t.datetime "last_used_at"
  end

  create_table "ruboto_tables", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string   "github",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["github"], name: "index_users_on_github", unique: true, using: :btree

  add_foreign_key "facts", "facts", column: "target_fact_id", name: "facts_target_fact_id_fkey", on_delete: :cascade
end
