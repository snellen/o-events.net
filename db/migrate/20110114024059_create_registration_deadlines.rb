class CreateRegistrationDeadlines < ActiveRecord::Migration
  def self.up
    create_table :registration_deadlines do |t|
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :registration_deadlines
  end
end
