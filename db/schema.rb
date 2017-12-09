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

ActiveRecord::Schema.define(version: 20171209211520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state", limit: 3
    t.string "postal"
    t.string "country", default: "US"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "person_id"
  end

  create_table "group_memberships", id: :serial, force: :cascade do |t|
    t.integer "group_id"
    t.integer "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
  end

  create_table "guardianships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "group_id"
    t.integer "sender_id"
    t.integer "recipient_id"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.float "price", default: 0.0
    t.boolean "deleted", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "list_id"
    t.integer "purchaser_id"
    t.integer "creator_id"
  end

  create_table "lists", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "person_id"
  end

  create_table "people", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "gender", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "last_year_viewed"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
