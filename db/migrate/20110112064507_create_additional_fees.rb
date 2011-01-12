class CreateAdditionalFees < ActiveRecord::Migration
  def self.up
    create_table :additional_fees do |t|
      t.string :name
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :additional_fees
  end
end
