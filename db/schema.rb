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

ActiveRecord::Schema.define(:version => 20120922054150) do

  create_table "articles", :force => true do |t|
    t.integer  "place_id",                                  :null => false
    t.string   "title",       :limit => 200,                :null => false
    t.integer  "category_cd",                :default => 0, :null => false
    t.string   "keywords",    :limit => 100
    t.string   "description", :limit => 100
    t.string   "author",      :limit => 100,                :null => false
    t.text     "body",                                      :null => false
    t.integer  "order",                      :default => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "audios", :force => true do |t|
    t.integer  "place_id",                               :null => false
    t.string   "name",                                   :null => false
    t.integer  "category_cd",             :default => 0, :null => false
    t.string   "duration"
    t.string   "attachment"
    t.integer  "attachment_size",         :default => 0
    t.string   "attachment_content_type"
    t.integer  "order",                   :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "infos", :force => true do |t|
    t.integer  "place_id",                                 :null => false
    t.string   "var",        :limit => 100,                :null => false
    t.string   "value"
    t.integer  "order",                     :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "infos", ["place_id", "var"], :name => "index_infos_on_place_id_and_var", :unique => true

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "action"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "permissions_roles", :id => false, :force => true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  create_table "pictures", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "image"
    t.integer  "image_size",         :default => 0
    t.string   "image_content_type"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "places", :force => true do |t|
    t.integer  "province_id",                                     :null => false
    t.string   "name",             :limit => 50,                  :null => false
    t.string   "key",              :limit => 30,                  :null => false
    t.integer  "videos_count",                     :default => 0
    t.integer  "audios_count",                     :default => 0
    t.integer  "articles_count",                   :default => 0
    t.integer  "infos_count",                      :default => 0
    t.string   "keywords",         :limit => 100
    t.string   "description",      :limit => 1000
    t.string   "map",                                             :null => false
    t.integer  "map_size",                         :default => 0
    t.string   "map_content_type"
    t.integer  "order",                            :default => 0
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "places", ["key"], :name => "index_places_on_key", :unique => true
  add_index "places", ["name"], :name => "index_places_on_name", :unique => true

  create_table "provinces", :force => true do |t|
    t.string   "name",         :limit => 30,                :null => false
    t.string   "key",          :limit => 30,                :null => false
    t.integer  "places_count",               :default => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "provinces", ["key"], :name => "index_provinces_on_key", :unique => true
  add_index "provinces", ["name"], :name => "index_provinces_on_name", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.integer  "place_id",                               :null => false
    t.string   "name",                                   :null => false
    t.string   "duration"
    t.string   "attachment"
    t.integer  "attachment_size",         :default => 0
    t.string   "attachment_content_type"
    t.string   "cover"
    t.integer  "cover_size",              :default => 0
    t.string   "cover_content_type"
    t.integer  "order",                   :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

end
