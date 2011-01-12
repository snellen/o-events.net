class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.integer :min_age
      t.integer :max_age
      t.string :sex

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
