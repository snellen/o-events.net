class CreateTeamRegistrations < ActiveRecord::Migration
  def self.up
    create_table :team_registrations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :team_registrations
  end
end
