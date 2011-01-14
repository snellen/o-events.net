class RemoveChipFromResult < ActiveRecord::Migration
  def self.up
    remove_column :results, :chip
  end

  def self.down
    add_column :results, :chip
  end
end
