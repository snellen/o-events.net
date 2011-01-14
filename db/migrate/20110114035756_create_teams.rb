class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.datetime :registration_time
      t.boolean :paid_by_club
      t.decimal :start_fee
      t.boolean :is_paid

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
