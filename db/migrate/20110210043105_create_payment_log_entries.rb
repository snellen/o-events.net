class CreatePaymentLogEntries < ActiveRecord::Migration
  def self.up
    create_table :payment_log_entries do |t|
      t.integer :severity
      t.string :controller_name
      t.string :action
      t.integer :payment_id
      t.string :ip_address
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_log_entries
  end
end
