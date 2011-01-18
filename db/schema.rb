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

ActiveRecord::Schema.define(:version => 20110118045435) do

  create_table "additional_fees", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "age_ranges", :force => true do |t|
    t.integer  "lower"
    t.integer  "upper"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_groups", :force => true do |t|
    t.boolean  "fee_age_dependent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chips", :force => true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "club_members", :force => true do |t|
    t.boolean  "is_default"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competing_clubs", :force => true do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competition_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitors", :force => true do |t|
    t.string   "license_number"
    t.string   "region_code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "province"
    t.string   "sex"
    t.integer  "birthdate_y"
    t.integer  "birthdate_m"
    t.integer  "birthdate_d"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nation_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nation_groups_nations", :id => false, :force => true do |t|
    t.integer "nation_group_id"
    t.integer "nation_id"
  end

  create_table "nations", :force => true do |t|
    t.string   "name"
    t.string   "ioc_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.string   "reference_number"
    t.date     "valuta"
    t.date     "fees_valuta"
    t.datetime "registration_time"
    t.string   "security_data"
    t.string   "type"
    t.decimal  "fees"
    t.boolean  "fees_included"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registration_deadlines", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "start_time"
    t.integer  "finish_time"
    t.integer  "run_time"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runs", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "age_limit_1"
    t.integer  "age_limit_2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "split_times", :force => true do |t|
    t.integer  "control_number"
    t.integer  "split_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "start_blocks", :force => true do |t|
    t.integer  "start_block"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "start_fees", :force => true do |t|
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "start_times", :force => true do |t|
    t.time     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", :force => true do |t|
    t.boolean  "is_leader"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "registration_time"
    t.boolean  "paid_by_club"
    t.decimal  "start_fee"
    t.boolean  "is_paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "total_results", :force => true do |t|
    t.integer  "total_time"
    t.integer  "score"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "license_number"
    t.string   "region_code"
    t.integer  "sicard_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "province"
    t.string   "sex"
    t.integer  "birthdate_y"
    t.integer  "birthdate_m"
    t.integer  "birthdate_d"
    t.boolean  "is_unclaimed"
    t.string   "password_reset_code"
  end

end
