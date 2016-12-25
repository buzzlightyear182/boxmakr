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

ActiveRecord::Schema.define(version: 20161224185020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "box_types", force: :cascade do |t|
    t.string  "name",                                null: false
    t.integer "base_price_centavos", default: 0,     null: false
    t.string  "base_price_currency", default: "PHP", null: false
    t.integer "threshold_centavos",  default: 0,     null: false
    t.string  "threshold_currency",  default: "PHP", null: false
    t.integer "max_item_count"
    t.index ["name"], name: "index_box_types_on_name", using: :btree
  end

  create_table "boxes", force: :cascade do |t|
    t.integer "forecast"
    t.integer "actual"
    t.integer "box_type_id"
    t.date    "month_date"
  end

  create_table "boxes_items", id: false, force: :cascade do |t|
    t.integer "box_id_id"
    t.integer "item_id_id"
    t.index ["box_id_id"], name: "index_boxes_items_on_box_id_id", using: :btree
    t.index ["item_id_id"], name: "index_boxes_items_on_item_id_id", using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string  "name",       null: false
    t.integer "company_id"
    t.string  "country"
    t.index ["name"], name: "index_brands_on_name", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string "name",        null: false
    t.float  "tariff_rate"
    t.index ["name"], name: "index_categories_on_name", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string "name",           null: false
    t.text   "address"
    t.string "country"
    t.string "email"
    t.string "contact_person"
    t.string "skype_id"
    t.index ["name"], name: "index_companies_on_name", using: :btree
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.string  "base_currency",                   null: false
    t.integer "amount_centavos", default: 0,     null: false
    t.string  "amount_currency", default: "PHP", null: false
    t.date    "date"
    t.boolean "active",          default: true
  end

  create_table "items", force: :cascade do |t|
    t.boolean "top_SKU"
    t.integer "shelf_life"
    t.integer "case_size"
    t.string  "description"
    t.integer "category_id"
    t.float   "case_weight"
    t.integer "brand_id"
    t.integer "case_price_centavos",   default: 0, null: false
    t.string  "case_price_currency"
    t.integer "case_pallet"
    t.string  "unit_size"
    t.float   "case_dimension_length"
    t.float   "case_dimension_width"
    t.float   "case_dimension_height"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
