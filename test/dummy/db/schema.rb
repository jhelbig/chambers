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

ActiveRecord::Schema.define(version: 2020_09_13_203831) do

  create_table "chambers_chamber_keys", force: :cascade do |t|
    t.string "chamber_uuid", null: false
    t.text "public", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chamber_uuid"], name: "index_chambers_chamber_keys_on_chamber_uuid", unique: true
  end

  create_table "chambers_chambers", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "host", null: false
    t.boolean "master", default: false, null: false
    t.boolean "slave", default: false, null: false
    t.boolean "secondary", default: false, null: false
    t.boolean "local", default: false, null: false
    t.boolean "active", default: false, null: false
    t.integer "level", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "host"], name: "index_chambers_chambers_on_name_and_host", unique: true
    t.index ["uuid"], name: "index_chambers_chambers_on_uuid", unique: true
  end

end
