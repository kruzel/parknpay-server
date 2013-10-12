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

ActiveRecord::Schema.define(:version => 20131005200751) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "city_id",         :null => false
    t.integer  "bank_account_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "areas", ["bank_account_id"], :name => "index_areas_on_bank_account_id"
  add_index "areas", ["city_id"], :name => "index_areas_on_city_id"

  create_table "bank_accounts", :force => true do |t|
    t.string   "name"
    t.string   "bank_name"
    t.string   "bank_code"
    t.string   "bank_office"
    t.string   "bank_account"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.boolean  "archive",       :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "cars", :force => true do |t|
    t.integer  "user_id",                                   :null => false
    t.string   "license_plate",                             :null => false
    t.string   "car_description",                           :null => false
    t.string   "car_image_file_name"
    t.string   "car_image_content_type"
    t.integer  "car_image_file_size"
    t.datetime "car_image_updated_at"
    t.boolean  "archive",                :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "cars", ["user_id"], :name => "index_cars_on_user_id"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.float    "x_pos"
    t.float    "y_pos"
    t.integer  "area_id",                                                      :null => false
    t.integer  "user_id",                                                      :null => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "archive",                                   :default => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.integer  "car_id"
    t.decimal  "amount",     :precision => 10, :scale => 0
  end

  add_index "payments", ["area_id"], :name => "index_payments_on_area_id"
  add_index "payments", ["user_id"], :name => "index_payments_on_user_id"

  create_table "rates", :force => true do |t|
    t.float    "rate"
    t.string   "currency"
    t.integer  "area_id",                             :null => false
    t.boolean  "archive",          :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "start_day_a_week"
    t.integer  "end_day_a_week"
    t.datetime "valid_start_at"
    t.datetime "valid_end_at"
  end

  add_index "rates", ["area_id"], :name => "index_rates_on_area_id"
  add_index "rates", ["valid_end_at"], :name => "index_rates_on_valid_end_at"
  add_index "rates", ["valid_start_at"], :name => "index_rates_on_valid_start_at"

  create_table "streets", :force => true do |t|
    t.string   "name"
    t.integer  "area_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "streets", ["area_id"], :name => "index_streets_on_area_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "",     :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.boolean  "active",                               :default => true
    t.string   "role",                                 :default => "user"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "gender"
    t.date     "dob"
    t.string   "address_st"
    t.string   "address_state"
    t.string   "address_postcode"
    t.string   "address_country"
    t.integer  "bank_account_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "terms_of_service"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
