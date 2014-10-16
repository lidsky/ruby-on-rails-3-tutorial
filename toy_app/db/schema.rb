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

ActiveRecord::Schema.define(version: 20141016072655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "content_sources", force: true do |t|
    t.string  "url",    limit: 2048, null: false
    t.integer "tag_id"
  end

  add_index "content_sources", ["url"], name: "content_sources_url_key", unique: true, using: :btree

  create_table "content_types", force: true do |t|
    t.string "type_string", limit: 64, null: false
  end

  add_index "content_types", ["type_string"], name: "ix_content_types_type_string", unique: true, using: :btree

  create_table "contents", force: true do |t|
    t.string   "url",                limit: 2048,  null: false
    t.string   "feed_id",            limit: 2048,  null: false
    t.string   "title",              limit: 1000,  null: false
    t.datetime "timestamp",                        null: false
    t.string   "description",        limit: 20000
    t.string   "image_url",          limit: 2048
    t.string   "icon_url",           limit: 2048
    t.integer  "rank"
    t.integer  "predicted_shares"
    t.integer  "real_shares"
    t.integer  "type_id"
    t.integer  "site_name_id"
    t.integer  "content_source_id"
    t.string   "feature_extraction"
    t.integer  "parent_cluster"
  end

  add_index "contents", ["content_source_id"], name: "ix_contents_content_source_id", using: :btree
  add_index "contents", ["feed_id"], name: "contents_feed_id_key", unique: true, using: :btree
  add_index "contents", ["site_name_id"], name: "ix_contents_site_name_id", using: :btree
  add_index "contents", ["title"], name: "ix_contents_title", using: :btree
  add_index "contents", ["type_id"], name: "ix_contents_type_id", using: :btree
  add_index "contents", ["url"], name: "contents_url_key", unique: true, using: :btree

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "migrate_version", primary_key: "repository_id", force: true do |t|
    t.text    "repository_path"
    t.integer "version"
  end

  create_table "site_names", force: true do |t|
    t.string "site_name", limit: 128, null: false
  end

  add_index "site_names", ["site_name"], name: "ix_site_names_site_name", unique: true, using: :btree

  create_table "social_shares", force: true do |t|
    t.integer  "facebook_shares"
    t.integer  "retweets"
    t.integer  "upvotes"
    t.datetime "timestamp",       null: false
    t.integer  "content_id",      null: false
  end

  create_table "tags", force: true do |t|
    t.string "tag_string", limit: 64, null: false
  end

  add_index "tags", ["tag_string"], name: "ix_tags_tag_string", unique: true, using: :btree

  create_table "tags_contents", force: true do |t|
    t.integer "tag_id"
    t.integer "content_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "content_sources", "tags", name: "content_sources_tag_id_fkey"
  add_foreign_key "contents", "content_sources", name: "contents_content_source_id_fkey"
  add_foreign_key "contents", "content_types", column: "type_id", name: "contents_type_id_fkey"
  add_foreign_key "contents", "site_names", name: "contents_site_name_id_fkey"
  add_foreign_key "social_shares", "contents", name: "social_shares_content_id_fkey"
  add_foreign_key "tags_contents", "contents", name: "tags_contents_content_id_fkey"
  add_foreign_key "tags_contents", "tags", name: "tags_contents_tag_id_fkey"
end
