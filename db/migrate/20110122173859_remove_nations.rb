class RemoveNations < ActiveRecord::Migration
  def self.up
    drop_table :nations
  end

  def self.down
    create_table :nations do |t|
      t.string :name
      t.string :ioc_code

      t.timestamps
    end
  end
end
