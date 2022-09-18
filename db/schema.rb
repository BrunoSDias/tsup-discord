# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_13_004318) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blockeds", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id", "target_id"], name: "index_blockeds_on_sender_id_and_target_id", unique: true
    t.index ["sender_id"], name: "index_blockeds_on_sender_id"
    t.index ["target_id", "sender_id"], name: "index_blockeds_on_target_id_and_sender_id", unique: true
    t.index ["target_id"], name: "index_blockeds_on_target_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendship_requests", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id", "target_id"], name: "index_friendship_requests_on_sender_id_and_target_id", unique: true
    t.index ["sender_id"], name: "index_friendship_requests_on_sender_id"
    t.index ["target_id", "sender_id"], name: "index_friendship_requests_on_target_id_and_sender_id", unique: true
    t.index ["target_id"], name: "index_friendship_requests_on_target_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user1_id", null: false
    t.bigint "user2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false
    t.index ["user1_id", "user2_id"], name: "index_friendships_on_user1_id_and_user2_id", unique: true
    t.index ["user1_id"], name: "index_friendships_on_user1_id"
    t.index ["user2_id", "user1_id"], name: "index_friendships_on_user2_id_and_user1_id", unique: true
    t.index ["user2_id"], name: "index_friendships_on_user2_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_chatroom_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_chatroom_id"], name: "index_messages_on_user_chatroom_id"
  end

  create_table "user_chatrooms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_user_chatrooms_on_chatroom_id"
    t.index ["user_id"], name: "index_user_chatrooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "available"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blockeds", "users", column: "sender_id"
  add_foreign_key "blockeds", "users", column: "target_id"
  add_foreign_key "friendship_requests", "users", column: "sender_id"
  add_foreign_key "friendship_requests", "users", column: "target_id"
  add_foreign_key "friendships", "users", column: "user1_id"
  add_foreign_key "friendships", "users", column: "user2_id"
  add_foreign_key "messages", "user_chatrooms"
  add_foreign_key "user_chatrooms", "chatrooms"
  add_foreign_key "user_chatrooms", "users"
end
