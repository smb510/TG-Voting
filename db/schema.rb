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

ActiveRecord::Schema.define(:version => 20120123044727) do

  create_table "elections", :force => true do |t|
    t.string   "position"
    t.string   "candidate1"
    t.string   "candidate2"
    t.string   "candidate3"
    t.string   "candidate4"
    t.string   "candidate5"
    t.boolean  "irv"
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rush_votes", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "vote"
  end

  create_table "rushes", :force => true do |t|
    t.string   "name"
    t.integer  "mentions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "proxy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "election_id"
    t.integer  "user"
    t.string   "token"
    t.text     "vote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
