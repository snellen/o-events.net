class CreateNationGroups < ActiveRecord::Migration
  def self.up
    create_table :nation_groups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :nation_groups
  end
end
