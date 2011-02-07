class AddFieldsToBill < ActiveRecord::Migration
  def self.up
    add_column :bills, :user_id, :integer
    add_column :bills, :first_name, :string
    add_column :bills, :last_name, :string
    add_column :bills, :address_line_1, :string
    add_column :bills, :address_line_2, :string
    add_column :bills, :city, :string
    add_column :bills, :zipcode, :string
    add_column :bills, :province, :string
    add_column :bills, :country_id, :integer
  end

  def self.down
    remove_column :bills, :country_id
    remove_column :bills, :province
    remove_column :bills, :zipcode
    remove_column :bills, :city
    remove_column :bills, :address_line_2
    remove_column :bills, :address_line_1
    remove_column :bills, :last_name
    remove_column :bills, :first_name
    remove_column :bills, :user_id
  end
end
