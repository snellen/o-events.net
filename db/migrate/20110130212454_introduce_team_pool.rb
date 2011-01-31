class IntroduceTeamPool < ActiveRecord::Migration
  def self.up
    rename_column :competitors, :event_id, :team_pool_id    
    rename_column :categories, :competition_group_id, :team_pool_id
    remove_column :competition_groups, :name
    add_column :competition_groups, :team_pool_id, :integer
    rename_column :teams, :competition_group_id, :team_pool_id
  end

  def self.down
    rename_column :competitors, :team_pool_id, :event_id    
    rename_column :categories, :team_pool_id, :competition_group_id
    add_column :competition_groups, :name, :string  
    remove_column :competition_groups, :team_pool_id
    rename_column :teams, :team_pool_id, :competition_group_id
  end
end
