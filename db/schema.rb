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

ActiveRecord::Schema.define(:version => 20120110125045) do

  create_table "games", :force => true do |t|
    t.string   "upload_id"
    t.integer  "player_id"
    t.string   "game"
    t.integer  "sets"
    t.integer  "legs"
    t.integer  "best_winning_leg"
    t.float    "three_dart_average"
    t.integer  "highest_checkout"
    t.integer  "highest_throw"
    t.integer  "doubles_hit"
    t.integer  "count_180"
    t.integer  "count_140"
    t.integer  "count_100"
    t.integer  "count_60"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "uploader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
