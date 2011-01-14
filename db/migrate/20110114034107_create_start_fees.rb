class CreateStartFees < ActiveRecord::Migration
  def self.up
    create_table :start_fees do |t|
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :start_fees
  end
end
