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

ActiveRecord::Schema[7.0].define(version: 2023_02_28_222419) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "operation_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "operation_type"
    t.bigint "table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_operation_categories_on_table_id"
  end

  create_table "operations", force: :cascade do |t|
    t.decimal "import", precision: 10, scale: 2
    t.text "description"
    t.text "attached_url"
    t.date "operation_date"
    t.bigint "user_id", null: false
    t.bigint "table_id", null: false
    t.bigint "operation_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_category_id"], name: "index_operations_on_operation_category_id"
    t.index ["table_id"], name: "index_operations_on_table_id"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "users_access", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.string "name"
    t.string "lastname"
    t.text "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "operation_categories", "tables"
  add_foreign_key "operations", "operation_categories"
  add_foreign_key "operations", "tables"
  add_foreign_key "operations", "users"
  add_foreign_key "tables", "users"
end
