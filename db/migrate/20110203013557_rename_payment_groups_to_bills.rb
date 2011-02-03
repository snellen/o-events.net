class RenamePaymentGroupsToBills < ActiveRecord::Migration
  def self.up
    rename_table :payment_groups, :bills
    remove_column :bills, :is_closed
    remove_column :bills, :closing_time
  end

  def self.down
    add_column :bills, :is_closed, :boolean
    add_column :bills, :closing_time, :datetime
    rename_table :bills, :payment_groups
  end
end
