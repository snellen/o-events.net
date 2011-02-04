class AddReferenceNumberToBill < ActiveRecord::Migration
  def self.up
    add_column :bills, :reference_number, :string
  end

  def self.down
    remove_column :bills, :reference_number
  end
end
