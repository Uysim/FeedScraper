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

ActiveRecord::Schema.define(version: 20150912023000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodies", force: :cascade do |t|
    t.text     "text"
    t.integer  "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bodies", ["content_id"], name: "index_bodies_on_content_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "link_url"
    t.boolean  "enable",     default: true
    t.integer  "website_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "categories", ["website_id"], name: "index_categories_on_website_id", using: :btree

  create_table "categories_selectors", force: :cascade do |t|
    t.string   "selector"
    t.string   "selector_type"
    t.integer  "website_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "categories_selectors", ["website_id"], name: "index_categories_selectors_on_website_id", using: :btree

  create_table "content_references", force: :cascade do |t|
    t.integer  "content_id"
    t.integer  "datarable_id"
    t.string   "datarable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "content_references", ["content_id"], name: "index_content_references_on_content_id", using: :btree

  create_table "content_selectors", force: :cascade do |t|
    t.string   "selector"
    t.string   "selector_type"
    t.integer  "website_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "content_selectors", ["website_id"], name: "index_content_selectors_on_website_id", using: :btree

  create_table "contents", force: :cascade do |t|
    t.string   "title"
    t.string   "link_url"
    t.string   "thumnail"
    t.string   "snippet"
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "headers", force: :cascade do |t|
    t.string   "text"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "link_url"
    t.integer  "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["content_id"], name: "index_images_on_content_id", using: :btree

  create_table "list_selectors", force: :cascade do |t|
    t.string   "selector"
    t.string   "selector_type"
    t.integer  "website_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "list_selectors", ["website_id"], name: "index_list_selectors_on_website_id", using: :btree

  create_table "remove_selectors", force: :cascade do |t|
    t.string   "selector"
    t.string   "selector_type"
    t.integer  "website_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "remove_selectors", ["website_id"], name: "index_remove_selectors_on_website_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "name"
    t.string   "link_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bodies", "contents"
  add_foreign_key "categories", "websites"
  add_foreign_key "categories_selectors", "websites"
  add_foreign_key "content_references", "contents"
  add_foreign_key "content_selectors", "websites"
  add_foreign_key "images", "contents"
  add_foreign_key "list_selectors", "websites"
  add_foreign_key "remove_selectors", "websites"
end
