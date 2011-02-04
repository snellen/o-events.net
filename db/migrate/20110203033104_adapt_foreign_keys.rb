class AdaptForeignKeys < ActiveRecord::Migration
  def self.up
    rename_column :teams, :payment_group_id, :bill_id
    rename_column :payments, :payment_group_id, :bill_id
  end

  def self.down
    rename_column :teams, :bill_id, :payment_group_id
    rename_column :payments, :bill_id, :payment_group_id 
  end
end
