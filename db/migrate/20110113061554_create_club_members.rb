class CreateClubMembers < ActiveRecord::Migration
  def self.up
    create_table :club_members do |t|
      t.boolean :is_default
      t.integer :role

      t.timestamps
    end
  end

  def self.down
    drop_table :club_members
  end
end
