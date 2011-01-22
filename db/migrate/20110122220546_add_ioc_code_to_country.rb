class AddIocCodeToCountry < ActiveRecord::Migration
  def self.up
    add_column :countries, :ioc_code, :string
  end

  def self.down
    remove_column :countries, :ioc_code
  end
end
