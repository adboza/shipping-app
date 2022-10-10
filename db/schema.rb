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

ActiveRecord::Schema[7.0].define(version: 2022_10_10_201724) do
  create_table "delivery_modalities", force: :cascade do |t|
    t.string "mod_name"
    t.decimal "mod_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distance_categories", force: :cascade do |t|
    t.integer "delivery_modality_id", null: false
    t.decimal "distance_price"
    t.integer "min_distance"
    t.integer "max_distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delivery_time"
    t.index ["delivery_modality_id"], name: "index_distance_categories_on_delivery_modality_id"
  end

  create_table "load_categories", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delivery_modality_id", null: false
    t.decimal "weight_price"
    t.index ["delivery_modality_id"], name: "index_load_categories_on_delivery_modality_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_access", default: 5
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_type", default: 0
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "licence_plate"
    t.date "year"
    t.integer "load_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "vehicle_type_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

  add_foreign_key "distance_categories", "delivery_modalities"
  add_foreign_key "load_categories", "delivery_modalities"
  add_foreign_key "vehicles", "vehicle_types"
end
