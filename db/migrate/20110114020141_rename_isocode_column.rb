class RenameIsocodeColumn < ActiveRecord::Migration
  def self.up
    rename_column :countries, :isocode, :iso_code
  end

  def self.down
    rename_column :countries, :iso_code, :isocode
  end
end
