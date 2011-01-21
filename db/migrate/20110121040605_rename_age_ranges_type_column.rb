class RenameAgeRangesTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :age_ranges, :type, :belongs_to
  end

  def self.down
    rename_column :age_ranges, :belongs_to, :type
  end
end
