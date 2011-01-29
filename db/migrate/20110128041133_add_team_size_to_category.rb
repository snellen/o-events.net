class AddTeamSizeToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :min_team_size, :integer
    add_column :categories, :max_team_size, :integer
  end

  def self.down
    remove_column :categories, :max_team_size
    remove_column :categories, :min_team_size
  end
end
