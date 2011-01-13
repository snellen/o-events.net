class CreateCategoryGroups < ActiveRecord::Migration
  def self.up
    create_table :category_groups do |t|
      t.boolean :fee_age_dependent

      t.timestamps
    end
  end

  def self.down
    drop_table :category_groups
  end
end
