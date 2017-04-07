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

ActiveRecord::Schema.define(version: 20170305051907) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "message_id",  limit: 4
    t.integer  "account_id",  limit: 4
    t.string   "activity",    limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["message_id"], name: "index_activities_on_message_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.integer  "message_id",        limit: 4
    t.integer  "account_id",        limit: 4
    t.integer  "user_id",           limit: 4
    t.text     "comment",           limit: 65535
    t.boolean  "completed"
    t.datetime "completed_at"
    t.text     "completed_comment", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["account_id", "completed"], name: "index_assignments_on_account_id_and_completed", using: :btree
  add_index "assignments", ["message_id", "completed"], name: "index_assignments_on_message_id_and_completed", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "message_id",      limit: 4
    t.integer  "account_id",      limit: 4
    t.text     "preview_url",     limit: 65535
    t.text     "url",             limit: 65535
    t.string   "attachment_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["message_id"], name: "index_attachments_on_message_id", using: :btree

  create_table "channels", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "account_id",   limit: 4
    t.string   "channel_type", limit: 255
    t.string   "status",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", force: :cascade do |t|
    t.integer  "message_id", limit: 4
    t.string   "label",      limit: 255
    t.integer  "account_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["account_id"], name: "index_labels_on_account_id", using: :btree
  add_index "labels", ["message_id"], name: "index_labels_on_message_id", using: :btree

  create_table "messages", id: false, force: :cascade do |t|
    t.integer  "id",                limit: 4,     default: 0,        null: false
    t.string   "message_type",      limit: 255
    t.integer  "account_id",        limit: 4
    t.integer  "channel_id",        limit: 4
    t.string   "external_id",       limit: 255
    t.string   "author",            limit: 255
    t.string   "author_id",         limit: 255
    t.text     "author_image_url",  limit: 65535
    t.text     "title",             limit: 65535
    t.text     "description",       limit: 65535
    t.text     "body",              limit: 65535
    t.integer  "likes_count",       limit: 4,     default: 0
    t.integer  "replies_count",     limit: 4,     default: 0
    t.integer  "shares_count",      limit: 4,     default: 0
    t.datetime "posted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unread_replies",                  default: false
    t.boolean  "deleted_replies",                 default: false
    t.string   "status",            limit: 255,   default: "active"
    t.boolean  "read",                            default: false
    t.boolean  "internal_origin",                 default: false
    t.string   "mentioned_id",      limit: 255
    t.integer  "parent_message_id", limit: 4
    t.integer  "parent_comment_id", limit: 4
  end

  add_index "messages", ["account_id", "status", "posted_at", "channel_id"], name: "index_messages_by_channel_id", length: {"account_id"=>nil, "status"=>191, "posted_at"=>nil, "channel_id"=>nil}, using: :btree
  add_index "messages", ["account_id", "status", "posted_at", "message_type"], name: "index_messages_by_message_type", length: {"account_id"=>nil, "status"=>191, "posted_at"=>nil, "message_type"=>191}, using: :btree

  create_table "messages_backup", force: :cascade do |t|
    t.string   "message_type",      limit: 255
    t.integer  "account_id",        limit: 4
    t.integer  "channel_id",        limit: 4
    t.string   "external_id",       limit: 255
    t.string   "author",            limit: 255
    t.string   "author_id",         limit: 255
    t.text     "author_image_url",  limit: 65535
    t.text     "title",             limit: 65535
    t.text     "description",       limit: 65535
    t.text     "body",              limit: 65535
    t.integer  "likes_count",       limit: 4,     default: 0
    t.integer  "replies_count",     limit: 4,     default: 0
    t.integer  "shares_count",      limit: 4,     default: 0
    t.datetime "posted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unread_replies",                  default: false
    t.boolean  "deleted_replies",                 default: false
    t.string   "status",            limit: 255,   default: "active"
    t.boolean  "read",                            default: false
    t.boolean  "internal_origin",                 default: false
    t.string   "mentioned_id",      limit: 255
    t.integer  "parent_message_id", limit: 4
    t.integer  "parent_comment_id", limit: 4
  end

  add_index "messages_backup", ["account_id", "status", "posted_at", "channel_id"], name: "index_messages_by_channel_id", length: {"account_id"=>nil, "status"=>191, "posted_at"=>nil, "channel_id"=>nil}, using: :btree
  add_index "messages_backup", ["account_id", "status", "posted_at", "message_type"], name: "index_messages_by_message_type", length: {"account_id"=>nil, "status"=>191, "posted_at"=>nil, "message_type"=>191}, using: :btree

end
