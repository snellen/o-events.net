class RemoveSecurityDataFromPayment < ActiveRecord::Migration
  def self.up
    remove_column :payments, :security_data
  end

  def self.down
    add_column :payments, :security_data, :string
  end
end
