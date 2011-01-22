class CreateCountryGroupsCountriesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :countries_country_groups, :id => false do |t|
      t.integer :country_id
      t.integer :country_group_id
    end
  end

  def self.down
    drop_table :countries_country_groups
  end
end
