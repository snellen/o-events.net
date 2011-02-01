class UpdatePaymentModels < ActiveRecord::Migration
  def self.up
    add_column :payment_groups, :is_closed, :boolean
    add_column :payment_groups, :closing_time, :datetime
    add_column :payment_groups, :exchange_rate, :decimal
    add_column :payment_groups, :is_paper_bill, :boolean
    add_column :payment_groups, :is_paper_bill_sent, :boolean
    add_column :payment_groups, :is_paid, :boolean
    remove_column :teams, :is_paid
  end

  def self.down
    remove_column :payment_groups, :is_closed
    remove_column :payment_groups, :closing_time
    remove_column :payment_groups, :exchange_rate
    remove_column :payment_groups, :is_paper_bill
    remove_column :payment_groups, :is_paper_bill_sent
    remove_column :payment_groups, :is_paid    
    add_column :teams, :is_paid, :boolean
  end
end
