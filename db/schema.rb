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

ActiveRecord::Schema[7.0].define(version: 2022_11_09_013442) do
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

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "route_id", null: false
    t.boolean "mark_favourite"
    t.index ["route_id"], name: "index_favorites_on_route_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "hours", force: :cascade do |t|
    t.time "hour"
    t.bigint "route_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_hours_on_route_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "near_places", force: :cascade do |t|
    t.bigint "place_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stop_station_id", null: false
    t.index ["place_id"], name: "index_near_places_on_place_id"
    t.index ["stop_station_id"], name: "index_near_places_on_stop_station_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.string "city"
    t.string "department"
    t.string "country"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "id_route"
    t.string "image"
    t.string "start_hour"
    t.string "end_hour"
  end

  create_table "spots", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "route_id", null: false
    t.string "address"
    t.index ["route_id"], name: "index_spots_on_route_id"
  end

  create_table "stop_stations", force: :cascade do |t|
    t.string "station_name"
    t.integer "previous_station"
    t.integer "next_station"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "route_id", null: false
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.string "city"
    t.string "department"
    t.string "country"
    t.string "route_code"
    t.index ["route_id"], name: "index_stop_stations_on_route_id"
  end

  create_table "stop_times", force: :cascade do |t|
    t.string "hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stop_station_id", null: false
    t.index ["stop_station_id"], name: "index_stop_times_on_stop_station_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "routes"
  add_foreign_key "favorites", "users"
  add_foreign_key "hours", "routes"
  add_foreign_key "near_places", "places"
  add_foreign_key "near_places", "stop_stations"
  add_foreign_key "spots", "routes"
  add_foreign_key "stop_stations", "routes"
  add_foreign_key "stop_times", "stop_stations"
end
