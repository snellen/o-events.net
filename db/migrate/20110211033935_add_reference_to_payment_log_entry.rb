class AddReferenceToPaymentLogEntry < ActiveRecord::Migration
  def self.up
    add_column :payment_log_entries, :payment_log_entry_id, :integer
  end

  def self.down
    remove_column :payment_log_entries, :payment_log_entry_id
  end
end
