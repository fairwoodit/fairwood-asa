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

ActiveRecord::Schema.define(version: 20151128155621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "instructor"
    t.date     "start"
    t.date     "end"
    t.string   "times"
    t.integer  "max_seats",                                default: 100, null: false
    t.boolean  "visible"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.text     "description"
    t.decimal  "cost",             precision: 6, scale: 2, default: 0.0, null: false
    t.integer  "min_seats",                                default: 1,   null: false
    t.boolean  "cash_only"
    t.integer  "min_grade",                                default: 0,   null: false
    t.integer  "max_grade",                                default: 5,   null: false
    t.string   "category"
    t.text     "html_description"
    t.string   "vendor_email"
    t.string   "vendor_phone"
    t.integer  "season_id"
  end

  add_index "activities", ["season_id"], name: "index_activities_on_season_id", using: :btree

  create_table "enrollments", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "student_id"
    t.boolean  "low_income"
    t.boolean  "committed"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "payment_type", default: "none"
  end

  add_index "enrollments", ["activity_id"], name: "index_enrollments_on_activity_id", using: :btree
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id", using: :btree

  create_table "parents", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "parents", ["email"], name: "index_parents_on_email", unique: true, using: :btree
  add_index "parents", ["reset_password_token"], name: "index_parents_on_reset_password_token", unique: true, using: :btree

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "parent_id"
    t.integer  "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "teacher_id"
  end

  add_index "students", ["parent_id"], name: "index_students_on_parent_id", using: :btree
  add_index "students", ["teacher_id"], name: "index_students_on_teacher_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "room"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teachers", ["last_name", "first_name"], name: "index_teachers_on_last_name_and_first_name", unique: true, using: :btree

  add_foreign_key "activities", "seasons"
  add_foreign_key "enrollments", "activities"
  add_foreign_key "enrollments", "students"
  add_foreign_key "students", "parents"
  add_foreign_key "students", "teachers"
end
