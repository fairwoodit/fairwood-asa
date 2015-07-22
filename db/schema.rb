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

ActiveRecord::Schema.define(version: 20150722191127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "instructor"
    t.date     "start"
    t.date     "end"
    t.string   "times"
    t.integer  "seats"
    t.boolean  "visible"
    t.date     "lakewood_eligibility_date"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.text     "description"
    t.decimal  "cost",                      precision: 6, scale: 2
  end

  create_table "parents", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "school"
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

  create_table "registrations", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "student_id"
    t.boolean  "low_income"
    t.boolean  "committed"
    t.boolean  "paid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "registrations", ["activity_id"], name: "index_registrations_on_activity_id", using: :btree
  add_index "registrations", ["student_id"], name: "index_registrations_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "parent_id"
    t.integer  "grade"
    t.string   "teacher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "students", ["parent_id"], name: "index_students_on_parent_id", using: :btree

  add_foreign_key "registrations", "activities"
  add_foreign_key "registrations", "students"
  add_foreign_key "students", "parents"
end
