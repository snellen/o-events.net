class CreateTeamPools < ActiveRecord::Migration
  def self.up
    create_table :team_pools do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :team_pools
  end
end
