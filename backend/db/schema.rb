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

ActiveRecord::Schema[8.1].define(version: 2025_12_19_193942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "conversions", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.decimal "exchange_rate", precision: 10, scale: 6, null: false
    t.datetime "rate_fetched_time", null: false
    t.string "source", limit: 3, null: false
    t.decimal "source_amount", precision: 15, scale: 2, null: false
    t.string "target", limit: 3, null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.string "base", limit: 3, null: false
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.decimal "rate", precision: 10, scale: 6, null: false
    t.string "target", limit: 3, null: false
    t.datetime "updated_at", null: false
    t.index ["base", "target", "date"], name: "index_exchange_rates_on_base_and_target_and_date", unique: true
  end
end
