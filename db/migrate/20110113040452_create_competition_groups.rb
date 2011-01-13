class CreateCompetitionGroups < ActiveRecord::Migration
  def self.up
    create_table :competition_groups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :competition_groups
  end
end
