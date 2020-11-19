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

ActiveRecord::Schema.define(version: 2020_11_15_155416) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments_volunteers", force: :cascade do |t|
    t.integer "volunteer_id"
    t.integer "department_id"
    t.index ["department_id"], name: "index_departments_volunteers_on_department_id"
    t.index ["volunteer_id"], name: "index_departments_volunteers_on_volunteer_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "color"
    t.datetime "start"
    t.datetime "end"
    t.boolean "all_day"
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_events_on_admin_id"
  end

  create_table "grades", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jobs_volunteers", force: :cascade do |t|
    t.integer "volunteer_id"
    t.integer "job_id"
    t.index ["job_id"], name: "index_jobs_volunteers_on_job_id"
    t.index ["volunteer_id"], name: "index_jobs_volunteers_on_volunteer_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.string "text"
    t.string "color", default: "primary"
    t.string "icon", default: "bell"
    t.string "link"
    t.boolean "read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_notifications_on_admin_id"
  end

  create_table "stands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stands_volunteers", force: :cascade do |t|
    t.integer "volunteer_id"
    t.integer "stand_id"
    t.index ["stand_id"], name: "index_stands_volunteers_on_stand_id"
    t.index ["volunteer_id"], name: "index_stands_volunteers_on_volunteer_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "balance"
    t.string "first_name"
    t.string "last_name"
    t.integer "grade_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grade_id"], name: "index_students_on_grade_id"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "grade_id", null: false
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grade_id"], name: "index_volunteers_on_grade_id"
  end

  add_foreign_key "events", "admins"
  add_foreign_key "notifications", "admins"
  add_foreign_key "students", "grades"
  add_foreign_key "volunteers", "grades"
end
