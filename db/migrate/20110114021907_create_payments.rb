class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.string :reference_number
      t.date :valuta
      t.date :fees_valuta
      t.datetime :registration_time
      t.string :security_data
      t.string :type
      t.decimal :fees
      t.boolean :fees_included
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
