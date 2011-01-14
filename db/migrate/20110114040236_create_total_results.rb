class CreateTotalResults < ActiveRecord::Migration
  def self.up
    create_table :total_results do |t|
      t.integer :total_time
      t.integer :score
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :total_results
  end
end
