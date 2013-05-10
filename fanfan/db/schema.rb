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

ActiveRecord::Schema.define(:version => 20130505153813) do

  create_table "activities", :force => true do |t|
    t.string   "subject"
    t.string   "status"
    t.string   "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost"
    t.datetime "occur_at"
    t.integer  "creator_id"
    t.integer  "atype",      :default => 0
  end

  create_table "balances", :force => true do |t|
    t.integer "user_id"
    t.decimal "amount"
  end

  create_table "fantuans", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fantuans_users", :force => true do |t|
    t.integer "user_id"
    t.integer "fantuan_id"
  end

  create_table "inbox_threads", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "thread_id"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "invitee_id"
    t.integer  "inviter_id"
    t.integer  "fantuan_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_threads", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.datetime "sent_date"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thread_id"
  end

  create_table "payments", :force => true do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.decimal "amount"
    t.boolean "confirmed"
    t.decimal "should_pay"
  end

  create_table "user_relations", :force => true do |t|
    t.integer  "userid_from"
    t.integer  "userid_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_thread", :id => false, :force => true do |t|
    t.integer "users_id"
    t.integer "threads_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
