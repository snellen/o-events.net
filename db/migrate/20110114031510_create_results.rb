class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :start_time
      t.integer :finish_time
      t.integer :run_time
      t.integer :rank
      t.integer :chip

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
