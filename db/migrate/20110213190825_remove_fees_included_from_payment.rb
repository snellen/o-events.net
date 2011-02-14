class RemoveFeesIncludedFromPayment < ActiveRecord::Migration
  def self.up
    remove_column :payments, :fees_included
  end

  def self.down
    add_column :payments, :fees_included, :string
  end
end
