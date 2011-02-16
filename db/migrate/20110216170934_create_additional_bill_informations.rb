class CreateAdditionalBillInformations < ActiveRecord::Migration
  def self.up
    create_table :additional_bill_informations do |t|
      t.integer :bill_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :additional_bill_informations
  end
end
