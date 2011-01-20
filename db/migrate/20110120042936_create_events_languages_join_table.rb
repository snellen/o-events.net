class CreateEventsLanguagesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :events_languages, :id => false do |t|
      t.integer :event_id
      t.integer :language_id
    end

  end

  def self.down
    drop_table :events_languages
  end
end
