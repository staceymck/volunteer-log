# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_04_204959) do

  create_table "activities", force: :cascade do |t|
    t.integer "volunteer_id", null: false
    t.integer "role_id", null: false
    t.date "date", null: false
    t.float "duration", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_activities_on_role_id"
    t.index ["volunteer_id"], name: "index_activities_on_volunteer_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "age_requirement", default: 0
    t.integer "frequency", default: 0
    t.string "days"
    t.boolean "background_check_required", default: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_roles_on_status"
    t.index ["title"], name: "index_roles_on_title"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "age_group", default: 0
    t.string "phone"
    t.string "email"
    t.date "birthday"
    t.string "occupation"
    t.string "employer"
    t.text "interests"
    t.integer "background_check_status", default: 0
    t.string "photo"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name"], name: "index_volunteers_on_first_name"
    t.index ["last_name"], name: "index_volunteers_on_last_name"
    t.index ["user_id"], name: "index_volunteers_on_user_id"
  end

  add_foreign_key "activities", "roles"
  add_foreign_key "activities", "volunteers"
  add_foreign_key "roles", "users"
  add_foreign_key "volunteers", "users"
end
