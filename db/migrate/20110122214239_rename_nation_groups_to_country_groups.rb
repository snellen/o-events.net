class RenameNationGroupsToCountryGroups < ActiveRecord::Migration
  def self.up
    rename_table :nation_groups, :country_groups
  end

  def self.down
    rename_table :country_groups, :nation_groups
  end
end
