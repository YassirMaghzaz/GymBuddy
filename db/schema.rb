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

ActiveRecord::Schema[7.1].define(version: 2024_09_05_154739) do
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

  create_table "gyms", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id", null: false
    t.index ["profile_id"], name: "index_gyms_on_profile_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id"
    t.integer "matched_profile_id"
    t.integer "matcher_id"
    t.index ["matched_profile_id"], name: "index_matches_on_matched_profile_id"
    t.index ["profile_id", "matched_profile_id"], name: "index_matches_on_profile_id_and_matched_profile_id", unique: true
    t.index ["profile_id"], name: "index_matches_on_profile_id"
  end

  create_table "objectives", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.float "progress"
    t.date "start_at"
    t.date "end_at"
    t.float "target_weight"
    t.float "current_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id", null: false
    t.index ["profile_id"], name: "index_objectives_on_profile_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.string "workout_days"
    t.string "workout_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id", null: false
    t.index ["profile_id"], name: "index_preferences_on_profile_id"
  end

  create_table "profile_images", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_images_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.string "gender"
    t.string "location"
    t.text "bio"
    t.text "availability"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "gyms", "profiles"
  add_foreign_key "matches", "profiles"
  add_foreign_key "matches", "profiles", column: "matched_profile_id"
  add_foreign_key "matches", "profiles", column: "matcher_id"
  add_foreign_key "objectives", "profiles"
  add_foreign_key "preferences", "profiles"
  add_foreign_key "profile_images", "profiles"
  add_foreign_key "profiles", "users"
end
