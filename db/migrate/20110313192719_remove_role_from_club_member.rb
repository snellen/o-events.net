class RemoveRoleFromClubMember < ActiveRecord::Migration
  def self.up
    remove_column :club_members, :role
  end

  def self.down
    add_column :club_members, :role, :integer
  end
end
