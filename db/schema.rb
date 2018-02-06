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

ActiveRecord::Schema.define(version: 20180206163327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application", force: :cascade do |t|
    t.string "character_id"
    t.string "status"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["status"], name: "index_applications_on_status"
    t.index ["token"], name: "index_applications_on_token"
  end

  create_table "recruiting_mailings", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reimbursements", force: :cascade do |t|
    t.string "user_id"
    t.string "zkb_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending", null: false
    t.index ["status"], name: "index_reimbursements_on_status"
    t.index ["user_id"], name: "index_reimbursements_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "sessions", primary_key: "session_id", id: :string, force: :cascade do |t|
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "user_id", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "character_id"
    t.string "corporation_id"
    t.string "alliance_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_users_on_character_id"
  end

end
