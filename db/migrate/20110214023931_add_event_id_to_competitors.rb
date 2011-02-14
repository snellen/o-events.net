class AddEventIdToCompetitors < ActiveRecord::Migration
  def self.up
    add_column :competitors, :event_id, :integer
  end

  def self.down
    remove_column :competitors, :event_id
  end
end
