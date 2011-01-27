class AddSortkeyToRun < ActiveRecord::Migration
  def self.up
    add_column :runs, :sortkey, :integer
  end

  def self.down
    remove_column :runs, :sortkey
  end
end
