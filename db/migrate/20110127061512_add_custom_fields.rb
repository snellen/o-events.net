class AddCustomFields < ActiveRecord::Migration
  def self.up
    add_column :competitors, :num1, :integer
    add_column :competitors, :num2, :integer
    add_column :competitors, :num3, :integer
    add_column :competitors, :text1, :string
    add_column :competitors, :text2, :string
    add_column :competitors, :text3, :string
    add_column :competitors, :flag1, :boolean
    add_column :competitors, :flag2, :boolean
    add_column :competitors, :flag3, :boolean
    add_column :teams, :num1, :integer
    add_column :teams, :num2, :integer
    add_column :teams, :num3, :integer
    add_column :teams, :text1, :string
    add_column :teams, :text2, :string
    add_column :teams, :text3, :string
    add_column :teams, :flag1, :boolean
    add_column :teams, :flag2, :boolean
    add_column :teams, :flag3, :boolean    
  end

  def self.down
    remove_column :competitors, :num1
    remove_column :competitors, :num2
    remove_column :competitors, :num3
    remove_column :competitors, :text1
    remove_column :competitors, :text2
    remove_column :competitors, :text3
    remove_column :competitors, :flag1
    remove_column :competitors, :flag2
    remove_column :competitors, :flag3
    remove_column :teams, :num1
    remove_column :teams, :num2
    remove_column :teams, :num3
    remove_column :teams, :text1
    remove_column :teams, :text2
    remove_column :teams, :text3
    remove_column :teams, :flag1
    remove_column :teams, :flag2
    remove_column :teams, :flag3        
  end
end
