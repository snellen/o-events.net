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

ActiveRecord::Schema.define(:version => 20110201045539) do

  create_table "additional_fees", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "age_range_id"
  end

  create_table "additional_fees_competition_groups", :id => false, :force => true do |t|
    t.integer "additional_fee_id"
    t.integer "competition_group_id"
  end

  create_table "age_ranges", :force => true do |t|
    t.integer  "lower"
    t.integer  "upper"
    t.string   "belongs_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_group_id"
    t.integer  "team_pool_id"
    t.integer  "min_team_size"
    t.integer  "max_team_size"
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
    t.integer  "run_id"
    t.integer  "competitor_id"
  end

  create_table "club_members", :force => true do |t|
    t.boolean  "is_default"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "club_id"
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
    t.integer  "country_id"
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
    t.integer  "country_id"
    t.integer  "club_id"
  end

  create_table "competition_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_pool_id"
  end

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "competition_group_id"
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
    t.integer  "country_id"
    t.integer  "nation_id"
    t.integer  "team_pool_id"
    t.integer  "competing_club_id"
    t.integer  "user_id"
    t.integer  "num1"
    t.integer  "num2"
    t.integer  "num3"
    t.string   "text1"
    t.string   "text2"
    t.string   "text3"
    t.boolean  "flag1"
    t.boolean  "flag2"
    t.boolean  "flag3"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ioc_code"
  end

  create_table "countries_country_groups", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "country_group_id"
  end

  create_table "country_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "event_id"
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
    t.integer  "club_id"
    t.integer  "country_id"
    t.integer  "currency_id"
  end

  create_table "events_languages", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "language_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "english_name"
    t.string   "native_name"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nation_groups_nations", :id => false, :force => true do |t|
    t.integer "nation_group_id"
    t.integer "nation_id"
  end

  create_table "payment_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_closed"
    t.datetime "closing_time"
    t.decimal  "exchange_rate"
    t.boolean  "is_paper_bill"
    t.boolean  "is_paper_bill_sent"
    t.boolean  "is_paid"
  end

  create_table "payments", :force => true do |t|
    t.string   "reference_number"
    t.date     "valuta"
    t.date     "fees_valuta"
    t.datetime "registration_time"
    t.string   "security_data"
    t.string   "method"
    t.decimal  "fees"
    t.boolean  "fees_included"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_group_id"
    t.integer  "currency_id"
  end

  create_table "registration_deadlines", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "results", :force => true do |t|
    t.integer  "start_time"
    t.integer  "finish_time"
    t.integer  "run_time"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chip_id"
  end

  create_table "runs", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "age_limit_1"
    t.integer  "age_limit_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competition_id"
    t.integer  "sortkey"
  end

  create_table "split_times", :force => true do |t|
    t.integer  "control_number"
    t.integer  "split_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "result_id"
  end

  create_table "start_blocks", :force => true do |t|
    t.integer  "start_block"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competitor_id"
    t.integer  "run_id"
  end

  create_table "start_fees", :force => true do |t|
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age_range_id"
    t.integer  "category_group_id"
    t.integer  "competition_group_id"
    t.integer  "registration_deadline_id"
    t.integer  "nation_group_id"
  end

  create_table "start_times", :force => true do |t|
    t.time     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competitor_id"
    t.integer  "run_id"
  end

  create_table "team_members", :force => true do |t|
    t.boolean  "is_leader"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competitor_id"
    t.integer  "team_id"
  end

  create_table "team_pools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_registrations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.integer  "category_id"
    t.integer  "competition_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "registration_time"
    t.boolean  "paid_by_club"
    t.decimal  "start_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_group_id"
    t.integer  "team_pool_id"
    t.integer  "competing_club_id"
    t.integer  "num1"
    t.integer  "num2"
    t.integer  "num3"
    t.string   "text1"
    t.string   "text2"
    t.string   "text3"
    t.boolean  "flag1"
    t.boolean  "flag2"
    t.boolean  "flag3"
  end

  create_table "total_results", :force => true do |t|
    t.integer  "total_time"
    t.integer  "score"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.integer  "competition_id"
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
    t.string   "password_reset_code"
    t.integer  "country_id"
    t.integer  "nation_id"
  end

end
