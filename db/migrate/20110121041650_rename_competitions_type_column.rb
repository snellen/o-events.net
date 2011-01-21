class RenameCompetitionsTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :competitions, :type, :kind
  end

  def self.down
   rename_column :competitions, :kind, :type
  end
end
