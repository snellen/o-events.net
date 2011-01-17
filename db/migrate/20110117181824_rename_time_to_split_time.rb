class RenameTimeToSplitTime < ActiveRecord::Migration
  def self.up
    rename_column :split_times, :time, :split_time
  end

  def self.down
    rename_column :split_times, :split_time, :time
  end
end
