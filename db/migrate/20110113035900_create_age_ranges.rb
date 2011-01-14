class CreateAgeRanges < ActiveRecord::Migration
  def self.up
    create_table :age_ranges do |t|
      t.integer :lower
      t.integer :upper
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :age_ranges
  end
end
