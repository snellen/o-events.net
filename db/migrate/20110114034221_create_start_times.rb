class CreateStartTimes < ActiveRecord::Migration
  def self.up
    create_table :start_times do |t|
      t.time :start_time

      t.timestamps
    end
  end

  def self.down
    drop_table :start_times
  end
end
