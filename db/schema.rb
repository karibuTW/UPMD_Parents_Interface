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

ActiveRecord::Schema.define(version: 2021_06_22_112600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bus_drivers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "company_name", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_bus_drivers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_bus_drivers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_bus_drivers_on_reset_password_token", unique: true
  end

  create_table "bus_services", force: :cascade do |t|
    t.integer "year"
    t.bigint "parent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id", "year"], name: "index_bus_services_on_parent_id_and_year", unique: true
    t.index ["parent_id"], name: "index_bus_services_on_parent_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "full_name", null: false
    t.date "birth_date", null: false
    t.integer "grade", default: 0
    t.bigint "parent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "public_comment"
    t.index ["parent_id"], name: "index_children_on_parent_id"
  end

  create_table "discount_codes", force: :cascade do |t|
    t.string "code"
    t.string "owner"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_discount_codes_on_code", unique: true
  end

  create_table "helloasso_order_items", force: :cascade do |t|
    t.bigint "helloasso_order_id", null: false
    t.string "order_item_id"
    t.datetime "date"
    t.decimal "amount"
    t.boolean "cancelled", default: false
    t.integer "order_item_type", default: 0
    t.integer "state", default: 0
    t.string "ticket_url"
    t.string "membership_card_url"
    t.integer "price_category", default: 0
    t.string "discount_code"
    t.decimal "discount_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["helloasso_order_id"], name: "index_helloasso_order_items_on_helloasso_order_id"
    t.index ["order_item_id"], name: "index_helloasso_order_items_on_order_item_id", unique: true
  end

  create_table "helloasso_orders", force: :cascade do |t|
    t.bigint "parent_id"
    t.decimal "amount_total"
    t.decimal "amount_vat"
    t.decimal "amount_discount"
    t.string "helloasso_order_id"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "form_slug", null: false
    t.integer "confirmation", default: 0
    t.bigint "discount_code_id"
    t.integer "year", default: 2021, null: false
    t.index ["discount_code_id"], name: "index_helloasso_orders_on_discount_code_id"
    t.index ["helloasso_order_id"], name: "index_helloasso_orders_on_helloasso_order_id", unique: true
    t.index ["parent_id"], name: "index_helloasso_orders_on_parent_id"
  end

  create_table "helloasso_payments", force: :cascade do |t|
    t.bigint "helloasso_order_id", null: false
    t.decimal "amount_tip"
    t.integer "cash_out_state", default: 0
    t.string "payment_receipt_url"
    t.string "fiscal_receipt_url"
    t.string "helloasso_payment_id"
    t.decimal "amount"
    t.datetime "date"
    t.integer "payment_means", default: 0
    t.integer "state", default: 0
    t.integer "payment_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["helloasso_order_id"], name: "index_helloasso_payments_on_helloasso_order_id"
    t.index ["helloasso_payment_id"], name: "index_helloasso_payments_on_helloasso_payment_id", unique: true
  end

  create_table "parents", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "full_name"
    t.string "phone_number"
    t.string "address"
    t.integer "preferred_language", default: 0, null: false
    t.boolean "mailing_list", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "public_comment"
    t.index ["confirmation_token"], name: "index_parents_on_confirmation_token", unique: true
    t.index ["email"], name: "index_parents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_parents_on_reset_password_token", unique: true
  end

  create_table "secondary_parents", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "full_name", null: false
    t.string "phone_number", null: false
    t.string "address", null: false
    t.integer "preferred_language", default: 0, null: false
    t.bigint "parent_id", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_secondary_parents_on_parent_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "viewers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_viewers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_viewers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_viewers_on_reset_password_token", unique: true
  end

  add_foreign_key "bus_services", "parents"
  add_foreign_key "children", "parents"
  add_foreign_key "helloasso_order_items", "helloasso_orders"
  add_foreign_key "helloasso_payments", "helloasso_orders"
  add_foreign_key "secondary_parents", "parents"
end
