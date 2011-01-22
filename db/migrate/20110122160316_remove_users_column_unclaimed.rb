class RemoveUsersColumnUnclaimed < ActiveRecord::Migration
  def self.up
    remove_column :users, :is_unclaimed
  end

  def self.down
    add_column :users, :is_unclaimed
  end
end
