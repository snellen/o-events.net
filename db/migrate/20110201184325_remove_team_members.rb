class RemoveTeamMembers < ActiveRecord::Migration
  def self.up
    drop_table :team_members
    add_column :teams, :user_id, :integer
    add_column :teams, :leader_id, :integer
    remove_column :payment_groups, :user_id
    remove_column :competitors, :team_pool_id
    add_column :teams, :nation_id, :integer
  end

  def self.down
    create_table "team_members", :force => true do |t|
      t.boolean  "is_leader"
      t.integer  "sortkey"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "competitor_id"
      t.integer  "team_id"
    end  
    remove_column :teams, :user_id
    remove_column :teams, :leader_id
    add_column :payment_groups, :user_id, :integer    
    add_column :competitors, :team_pool_id, :integer
    remove_column :teams, :nation_id
  end
end
