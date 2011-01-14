class CreatePaymentGroups < ActiveRecord::Migration
  def self.up
    create_table :payment_groups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_groups
  end
end
