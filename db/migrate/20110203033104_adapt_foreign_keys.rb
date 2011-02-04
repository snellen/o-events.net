class AdaptForeignKeys < ActiveRecord::Migration
  def self.up
    rename_column :teams, :competition_group_id, :bill_id
    rename_column :payments, :competition_group_id, :bill_id
  end

  def self.down
    rename_column :teams, :bill_id, :competition_group_id
    rename_column :payments, :bill_id, :competition_group_id 
  end
end
