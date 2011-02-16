class AddPrecisionAndScaleToDecimalColumns < ActiveRecord::Migration
  def self.up
    change_column :teams, :start_fee, :decimal, :precision => 8, :scale => 2
    change_column :additional_fees, :amount, :decimal, :precision => 8, :scale => 2
    change_column :bills, :exchange_rate, :decimal, :precision => 12, :scale => 6
    change_column :payments, :amount, :decimal, :precision => 8, :scale => 2
    change_column :payments, :fees, :decimal, :precision => 8, :scale => 2
    change_column :start_fees, :amount, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :teams, :start_fee, :decimal, :precision => 10, :scale => 0
    change_column :additional_fees, :amount, :decimal, :precision => 10, :scale => 0
    change_column :bills, :exchange_rate, :decimal, :precision => 10, :scale => 0
    change_column :payments, :amount, :decimal, :precision => 10, :scale => 0
    change_column :payments, :fees, :decimal, :precision => 10, :scale => 0
    change_column :start_fees, :amount, :decimal, :precision => 10, :scale => 0
  end
end
