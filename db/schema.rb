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

ActiveRecord::Schema.define(version: 20160920122826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["user_id"], name: "index_avatars_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "full_text"
    t.integer  "user_id"
    t.integer  "number"
    t.integer  "topic_id"
    t.integer  "answer_to_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index "to_tsvector('hungarian'::regconfig, full_text)", name: "index_posts_on_full_text", using: :gin
    t.index ["answer_to_id"], name: "index_posts_on_answer_to_id", using: :btree
    t.index ["topic_id"], name: "index_posts_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.index ["user_id"], name: "index_topics_on_user_id", using: :btree
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["post_id"], name: "index_uploads_on_post_id", using: :btree
    t.index ["user_id"], name: "index_uploads_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.boolean  "active",            default: false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.integer  "login_count",       default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "signature"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "downvote",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["downvote"], name: "index_votes_on_downvote", using: :btree
    t.index ["post_id"], name: "index_votes_on_post_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  add_foreign_key "avatars", "users"
  add_foreign_key "posts", "topics"
  add_foreign_key "posts", "users"
  add_foreign_key "topics", "users"
  add_foreign_key "uploads", "posts"
  add_foreign_key "uploads", "users"
  add_foreign_key "votes", "posts"
  add_foreign_key "votes", "users"
end
