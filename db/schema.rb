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

ActiveRecord::Schema.define(version: 20131006121000) do

  create_table "boards", force: true do |t|
    t.string   "subdomain"
    t.string   "title"
    t.string   "tagline"
    t.string   "icon"
    t.string   "syndicates",                default: [],                 array: true
    t.string   "suggestions"
    t.text     "benefits"
    t.integer  "price_cents",               default: 0,     null: false
    t.string   "price_currency",            default: "USD", null: false
    t.string   "uuid",           limit: 36,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boards", ["subdomain"], name: "index_boards_on_subdomain", using: :btree

  create_table "categories", force: true do |t|
    t.integer  "board_id"
    t.string   "name"
    t.string   "uuid",       limit: 36, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["board_id"], name: "index_categories_on_board_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.string   "location"
    t.text     "description"
    t.string   "instructions"
    t.datetime "expires_at"
    t.boolean  "highlight",               default: false
    t.string   "company"
    t.string   "url"
    t.string   "email"
    t.string   "uuid",         limit: 36,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["category_id", "expires_at"], name: "index_jobs_on_category_id_and_expires_at", using: :btree
  add_index "jobs", ["expires_at"], name: "index_jobs_on_expires_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
