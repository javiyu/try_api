# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150807083935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string  "name",     null: false
    t.integer "sport_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "events", ["name"], name: "index_events_on_name", using: :btree
  add_index "events", ["sport_id"], name: "index_events_on_sport_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  add_index "permissions_roles", ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
  add_index "permissions_roles", ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string  "name",    null: false
    t.integer "user_id", null: false
  end

  add_index "sports", ["name"], name: "index_sports_on_name", using: :btree
  add_index "sports", ["user_id"], name: "index_sports_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "name",     null: false
    t.string  "password", null: false
    t.integer "role_id",  null: false
  end

  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["password"], name: "index_users_on_password", using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "events", "sports"
  add_foreign_key "events", "users"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "sports", "users"
  add_foreign_key "users", "roles"
end
