class MiscCorrections < ActiveRecord::Migration
  def self.up
    add_column :team_pools, :event_id, :integer
    rename_column :additional_fees, :event_id, :competition_group_id
    drop_table :additional_fees_competition_groups
    add_column :competitors, :team_id, :integer
  end
  
  def self.down
    remove_column :team_pools, :event_id
    rename_column :additional_fees, :competition_group_id, :event_id
    create_table :additional_fees_competition_groups, :id => false do |t|
      t.integer :additional_fee_id
      t.integer :competition_group_id
    end    
    remove_column :competitors, :team_id
  end
end
