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

ActiveRecord::Schema.define(version: 20141008155819) do

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "favorite_tweets", force: true do |t|
    t.string   "tweet_id"
    t.string   "integer"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "following_relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "following_relationships", ["followed_user_id"], name: "index_following_relationships_on_followed_user_id"
  add_index "following_relationships", ["follower_id"], name: "index_following_relationships_on_follower_id"

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "simple_hashtag_hashtaggings", force: true do |t|
    t.integer "hashtag_id"
    t.integer "hashtaggable_id"
    t.string  "hashtaggable_type"
  end

  add_index "simple_hashtag_hashtaggings", ["hashtag_id"], name: "index_simple_hashtag_hashtaggings_on_hashtag_id"
  add_index "simple_hashtag_hashtaggings", ["hashtaggable_id", "hashtaggable_type"], name: "index_hashtaggings_hashtaggable_id_hashtaggable_type"

  create_table "simple_hashtag_hashtags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private",                  default: true
    t.string   "location",      limit: 30
    t.boolean  "show_location",            default: false
    t.integer  "retweet_id"
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
