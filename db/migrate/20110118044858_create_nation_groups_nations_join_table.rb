class CreateNationGroupsNationsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :nation_groups_nations, :id => false do |t|
      t.integer :nation_group_id
      t.integer :nation_id
    end
  end

  def self.down
    drop_table :nation_groups_nations
  end
end

