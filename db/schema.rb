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

ActiveRecord::Schema.define(version: 20170410085343) do

  create_table "appointments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "time_slot_id"
    t.integer  "patient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "registered",   null: false
  end

  create_table "doctor_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "speciality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "doctor_type_id"
    t.string   "full_name",      null: false
    t.string   "first_name",     null: false
    t.string   "middle_name"
    t.string   "last_name",      null: false
    t.boolean  "gender",         null: false
    t.string   "telephone",      null: false
    t.string   "email",          null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "patients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "full_name",                null: false
    t.string   "first_name",               null: false
    t.string   "middle_name"
    t.string   "last_name",                null: false
    t.boolean  "gender",                   null: false
    t.date     "date_of_birth",            null: false
    t.string   "telephone",                null: false
    t.string   "email",         limit: 40, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "staffs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "full_name",   null: false
    t.string   "first_name",  null: false
    t.string   "middle_name"
    t.string   "last_name",   null: false
    t.boolean  "gender",      null: false
    t.string   "telephone",   null: false
    t.string   "email",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "time_slots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "app_date"
    t.time     "from_time"
    t.time     "to_time"
    t.integer  "doctor_id"
    t.integer  "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                     null: false
    t.string   "password_digest",           null: false
    t.integer  "role",            limit: 1, null: false
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.integer  "staff_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "vitals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.float    "height",       limit: 24
    t.float    "weight",       limit: 24
    t.float    "bmi",          limit: 24
    t.float    "blood_group",  limit: 24
    t.float    "temp",         limit: 24
    t.float    "pulse",        limit: 24
    t.float    "res_rate",     limit: 24
    t.float    "bld_pressure", limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
