class CreateEventSettings < ActiveRecord::Migration
  def self.up
    create_table :event_settings do |t|
      t.string :name
      t.string :value
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :event_settings
  end
end
