class AddSortkeyToCompetitor < ActiveRecord::Migration
  def self.up
    add_column :competitors, :sortkey, :integer
  end

  def self.down
    remove_column :competitors, :sortkey
  end
end
