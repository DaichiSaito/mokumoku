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

ActiveRecord::Schema.define(version: 2018_12_30_075457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tokyo", default: true, null: false
  end

  create_table "attends", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "mokumoku_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mokumoku_id"], name: "index_attends_on_mokumoku_id"
    t.index ["user_id", "mokumoku_id"], name: "index_attends_on_user_id_and_mokumoku_id", unique: true
    t.index ["user_id"], name: "index_attends_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "mokumoku_id"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mokumoku_id"], name: "index_comments_on_mokumoku_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorite_areas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_favorite_areas_on_area_id"
    t.index ["user_id"], name: "index_favorite_areas_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "mokumoku_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mokumoku_id"], name: "index_likes_on_mokumoku_id"
    t.index ["user_id", "mokumoku_id"], name: "index_likes_on_user_id_and_mokumoku_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "mokumokus", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "area_id"
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "open_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "online", default: false
    t.index ["area_id"], name: "index_mokumokus_on_area_id"
    t.index ["user_id"], name: "index_mokumokus_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notified_by_id"
    t.bigint "mokumoku_id"
    t.integer "notified_type", null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mokumoku_id"], name: "index_notifications_on_mokumoku_id"
    t.index ["notified_by_id"], name: "index_notifications_on_notified_by_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "profile"
    t.integer "role", default: 0
    t.string "screen_name", default: ""
    t.boolean "mail_receive", default: true
    t.string "appearin_url"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "attends", "mokumokus"
  add_foreign_key "attends", "users"
  add_foreign_key "comments", "mokumokus"
  add_foreign_key "comments", "users"
  add_foreign_key "mokumokus", "areas"
  add_foreign_key "mokumokus", "users"
  add_foreign_key "notifications", "mokumokus"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
end
