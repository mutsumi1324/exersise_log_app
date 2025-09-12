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

ActiveRecord::Schema[8.0].define(version: 2025_09_06_014354) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "body_parts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_body_parts_on_name", unique: true
  end

  create_table "days", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "occurred_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "occurred_on"], name: "index_days_on_user_id_and_occurred_on", unique: true
    t.index ["user_id"], name: "index_days_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.bigint "body_part_id", null: false
    t.bigint "created_by_user_id"
    t.string "name"
    t.boolean "is_default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_part_id"], name: "index_exercises_on_body_part_id"
    t.index ["created_by_user_id"], name: "index_exercises_on_created_by_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "height"
    t.decimal "body_weight", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workout_sets", force: :cascade do |t|
    t.bigint "day_id", null: false
    t.bigint "exercise_id", null: false
    t.decimal "weight", precision: 5, scale: 2
    t.integer "reps"
    t.integer "rir"
    t.text "memo"
    t.integer "set_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id", "exercise_id", "set_number"], name: "index_workout_sets_on_day_id_and_exercise_id_and_set_number", unique: true
    t.index ["day_id"], name: "index_workout_sets_on_day_id"
    t.index ["exercise_id"], name: "index_workout_sets_on_exercise_id"
  end

  add_foreign_key "days", "users"
  add_foreign_key "exercises", "body_parts"
  add_foreign_key "exercises", "users", column: "created_by_user_id"
  add_foreign_key "workout_sets", "days"
  add_foreign_key "workout_sets", "exercises"
end
