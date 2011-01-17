class CreateStartBlocks < ActiveRecord::Migration
  def self.up
    create_table :start_blocks do |t|
      t.integer :start_block

      t.timestamps
    end
  end

  def self.down
    drop_table :start_blocks
  end
end
