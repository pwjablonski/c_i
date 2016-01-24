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

ActiveRecord::Schema.define(version: 20160116163354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_data", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.integer  "attendance_list_id"
    t.boolean  "present"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "attendance_lists", force: :cascade do |t|
    t.integer  "classroom_id"
    t.date     "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ca_data", force: :cascade do |t|
    t.integer  "total_points"
    t.integer  "student_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "classroom_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_verified",  default: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "date"
    t.string   "location"
    t.string   "image_url"
    t.integer  "eventbrite_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title"
    t.string   "message"
    t.date     "date_posted"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "tag_line"
    t.string   "description"
    t.string   "image_url"
    t.integer  "student_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "devpost_url"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "school_name"
    t.string   "school_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "classroom_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_name"
    t.text     "about_me"
    t.string   "github_username"
    t.string   "codecademy_username"
    t.string   "devpost_username"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "credly_member_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_name"
    t.text     "about_me"
    t.string   "github_username"
    t.string   "codecademy_username"
    t.string   "devpost_username"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                                                                               null: false
    t.string   "encrypted_password",     default: "",                                                                               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                                                                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                                                                                        null: false
    t.datetime "updated_at",                                                                                                        null: false
    t.integer  "role"
    t.string   "provider"
    t.string   "uid"
    t.string   "devpost_url"
    t.string   "image",                  default: "http://riskid.nl/assets/testimonials/user-3995d1ed5f9b6ea6ef9c7bc9ead47415.jpg"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
