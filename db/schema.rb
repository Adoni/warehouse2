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

ActiveRecord::Schema.define(:version => 20130107070826) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "inttype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "each_houses", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "spec"
    t.integer  "amount"
    t.integer  "category_id"
    t.integer  "main_list_id"
    t.integer  "each_house_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.decimal  "price",         :precision => 8, :scale => 2
    t.string   "unit"
    t.integer  "in_amount"
    t.integer  "out_amount"
  end

  create_table "main_lists", :force => true do |t|
    t.integer  "source"
    t.integer  "destination"
    t.integer  "total_amount"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.decimal  "total_price",  :precision => 8, :scale => 2
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "type_desc"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "each_house_id"
    t.integer  "admin"
  end

  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
