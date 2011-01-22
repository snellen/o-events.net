class UpdateForeignKeys < ActiveRecord::Migration
  def self.up    
    remove_column :teams, :category_id
    add_column :teams, :competition_group_id, :integer
    add_column :teams, :competing_club_id, :integer
    add_column :team_registrations, :team_id, :integer
    add_column :team_registrations, :category_id, :integer
    add_column :team_registrations, :competition_id, :integer
    remove_column :categories, :competition_id
    add_column :categories, :competition_group_id, :integer
    remove_column :category_groups, :competition_group_id
  end

  def self.down
    add_column :teams, :category_id, :integer
    remove_column :teams, :competition_group_id
    remove_column :teams, :competing_club_id
    remove_column :team_registrations, :team_id
    remove_column :team_registrations, :category_id
    remove_column :team_registrations, :competition_id
    add_column :categories, :competition_id, :integer
    remove_column :categories, :competition_group_id
    add_column :category_groups, :competition_group_id, :integer
  end
end
