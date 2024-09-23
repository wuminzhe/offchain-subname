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

ActiveRecord::Schema[7.2].define(version: 2024_09_23_040216) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.integer "coin_type"
    t.bigint "subname_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subname_id"], name: "index_addresses_on_subname_id"
  end

  create_table "content_hashes", force: :cascade do |t|
    t.string "content"
    t.bigint "subname_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subname_id"], name: "index_content_hashes_on_subname_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_domains_on_name", unique: true
  end

  create_table "subnames", force: :cascade do |t|
    t.string "name"
    t.bigint "domain_id", null: false
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_subnames_on_domain_id"
    t.index ["name"], name: "index_subnames_on_name"
  end

  create_table "texts", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.bigint "subname_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subname_id"], name: "index_texts_on_subname_id"
  end

  add_foreign_key "addresses", "subnames"
  add_foreign_key "content_hashes", "subnames"
  add_foreign_key "subnames", "domains"
  add_foreign_key "texts", "subnames"
end
