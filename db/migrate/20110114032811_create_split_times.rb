class CreateSplitTimes < ActiveRecord::Migration
  def self.up
    create_table :split_times do |t|
      t.integer :control_number
      t.integer :time

      t.timestamps
    end
  end

  def self.down
    drop_table :split_times
  end
end
