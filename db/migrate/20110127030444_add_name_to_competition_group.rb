class AddNameToCompetitionGroup < ActiveRecord::Migration
  def self.up
    add_column :competition_groups, :name, :string
  end

  def self.down
    remove_column :competition_groups, :name
  end
end
