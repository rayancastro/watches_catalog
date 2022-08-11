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

ActiveRecord::Schema[7.0].define(version: 2022_08_11_110151) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discount_rules", force: :cascade do |t|
    t.bigint "watch_id", null: false
    t.integer "bundle_size"
    t.integer "bundle_price_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["watch_id"], name: "index_discount_rules_on_watch_id"
  end

  create_table "watches", force: :cascade do |t|
    t.string "name"
    t.integer "unit_price_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "discount_rules", "watches"
end
