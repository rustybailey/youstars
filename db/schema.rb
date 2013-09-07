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

ActiveRecord::Schema.define(version: 20130907015021) do

  create_table "categories", force: true do |t|
    t.integer  "youtube_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "youtube_id"
    t.string   "gender"
    t.string   "location"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels_topics", id: false, force: true do |t|
    t.integer "channel_id"
    t.integer "topic_id"
  end

  add_index "channels_topics", ["channel_id", "topic_id"], name: "index_channels_topics_on_channel_id_and_topic_id", unique: true
  add_index "channels_topics", ["topic_id"], name: "index_channels_topics_on_topic_id"

  create_table "channels_topics_calculated", id: false, force: true do |t|
    t.integer "channel_id"
    t.integer "topic_id"
  end

  add_index "channels_topics_calculated", ["channel_id", "topic_id"], name: "index_channels_topics_calculated_on_channel_id_and_topic_id"
  add_index "channels_topics_calculated", ["topic_id"], name: "index_channels_topics_calculated_on_topic_id"

  create_table "ratings", force: true do |t|
    t.integer "user_id"
    t.integer "video_id"
    t.integer "score"
  end

  create_table "topics", force: true do |t|
    t.string   "mid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total"
    t.string   "name"
  end

  create_table "unique_views", force: true do |t|
    t.integer  "view_id"
    t.string   "youtube_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth2_token"
    t.string   "refresh_token"
    t.string   "guid"
    t.string   "channel_name"
    t.text     "custom_suggestions"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "videos", force: true do |t|
    t.string   "youtube_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "views", force: true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight",            default: 0
    t.integer  "unique_view_count"
  end

end
