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

ActiveRecord::Schema[7.1].define(version: 2025_06_28_094955) do
  create_table "addresses", charset: "utf8mb3", force: :cascade do |t|
    t.string "postal_code"
    t.integer "prefecture_id"
    t.string "city"
    t.string "address"
    t.string "building"
    t.string "phone_number"
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_addresses_on_order_id"
  end

  create_table "orders", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.bigint "user_id", null: false
    t.integer "status_id"
    t.integer "category_id"
    t.integer "shipping_fee_status_id"
    t.integer "prefecture_id"
    t.integer "scheduled_delivery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "nickname"
    t.string "email"
    t.string "encrypted_password"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "orders"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "users"
end
