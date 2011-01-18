class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :license_number, :string
    add_column :users, :region_code, :string
    add_column :users, :sicard_number, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :sex, :string
    add_column :users, :birthdate_y, :integer
    add_column :users, :birthdate_m, :integer
    add_column :users, :birthdate_d, :integer
    add_column :users, :is_unclaimed, :boolean
    add_column :users, :password_reset_code, :string
    rename_column :users, :name, :username
  end

  def self.down
    remove_column :users, :is_unclaimed
    remove_column :users, :birthdate_d
    remove_column :users, :birthdate_m
    remove_column :users, :birthdate_y
    remove_column :users, :sex
    remove_column :users, :province
    remove_column :users, :city
    remove_column :users, :zipcode
    remove_column :users, :address_line_2
    remove_column :users, :address_line_1
    remove_column :users, :phone
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :sicard_number
    remove_column :users, :region_code
    remove_column :users, :license_number
    remove_column :users, :password_reset_code
    rename_column :users, :username, :name
  end
end
