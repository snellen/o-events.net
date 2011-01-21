class RenamePaymentsTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :payments, :type, :method
  end

  def self.down
    rename_column :payments, :method, :type
  end
end
