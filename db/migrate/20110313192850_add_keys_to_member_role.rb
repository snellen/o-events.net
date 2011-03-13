class AddKeysToMemberRole < ActiveRecord::Migration
  def self.up
    add_column :member_roles, :club_member_id, :integer
    add_column :member_roles, :event_id, :integer
  end

  def self.down
    remove_column :member_roles, :event_id
    remove_column :member_roles, :club_member_id
  end
end
