class CreateMemberRoles < ActiveRecord::Migration
  def self.up
    create_table :member_roles do |t|
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :member_roles
  end
end
