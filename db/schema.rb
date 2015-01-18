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

ActiveRecord::Schema.define(version: 20141128105239) do

  create_table "articles", force: true do |t|
    t.string   "slug",             limit: 150
    t.string   "title",            limit: 150
    t.text     "content"
    t.boolean  "meta_generated"
    t.string   "meta_title",       limit: 200
    t.string   "meta_description", limit: 200
    t.string   "meta_keywords",    limit: 200
    t.string   "author",           limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enquiries", force: true do |t|
    t.string   "name"
    t.string   "email_address"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "slug",             limit: 150
    t.integer  "left_value"
    t.integer  "right_value"
    t.integer  "ancestor_id"
    t.integer  "depth"
    t.string   "title",            limit: 150
    t.text     "content"
    t.boolean  "meta_generated"
    t.string   "meta_title",       limit: 200
    t.string   "meta_description", limit: 200
    t.string   "meta_keywords",    limit: 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email_address",   limit: 100
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
