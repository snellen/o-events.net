class CreateRuns < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.string :name
      t.date :date
      t.integer :age_limit_1
      t.integer :age_limit_2

      t.timestamps
    end
  end

  def self.down
    drop_table :runs
  end
end
