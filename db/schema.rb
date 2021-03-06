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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110203100719) do

  create_table "blog_posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title"
    t.text     "text"
    t.string   "url"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "interesting",  :default => false, :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.string   "rss"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "user_id"
  end

  create_table "cities", :force => true do |t|
    t.integer "region_id"
    t.float   "lat"
    t.float   "lon"
    t.string  "title"
    t.integer "users_count", :default => 0
  end

  create_table "cities_job_offers", :id => false, :force => true do |t|
    t.integer "city_id"
    t.integer "job_offer_id"
  end

  create_table "github_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_url"
  end

  create_table "job_offers", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salary"
    t.text     "urls"
    t.string   "joobleid"
    t.date     "published_on"
    t.boolean  "interesting",  :default => false, :null => false
  end

  create_table "linked_in_accounts", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "avatar_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "regions", :force => true do |t|
    t.string "title"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tweets", :force => true do |t|
    t.string   "text"
    t.datetime "published_at"
    t.string   "twitterid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.boolean  "interesting",  :default => false, :null => false
    t.text     "html"
  end

  create_table "twitter_accounts", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "avatar_url"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "gender"
    t.string   "relation_to_ruby"
    t.string   "os"
    t.string   "editor"
    t.integer  "birth_year"
    t.string   "tabs_or_spaces"
    t.integer  "heard_about_ruby_year"
    t.integer  "started_ruby_year"
    t.string   "url"
    t.boolean  "admin",                 :default => false, :null => false
    t.string   "ip"
    t.text     "useragent"
  end

end
