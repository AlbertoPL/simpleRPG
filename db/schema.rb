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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120709022101) do

  create_table "characters", :force => true do |t|
    t.integer  "hp",         :default => 50
    t.integer  "mindamage",  :default => 0
    t.integer  "maxdamage",  :default => 10
    t.integer  "gold",       :default => 0
    t.integer  "level",      :default => 1
    t.integer  "exp",        :default => 0
    t.integer  "hpperlevel", :default => 10
    t.integer  "expperkill", :default => 20
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "maxhp",      :default => 50
    t.integer  "enemy_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                     :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "character_id"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
