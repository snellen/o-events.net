class CreateCompetingClubs < ActiveRecord::Migration
  def self.up
    create_table :competing_clubs do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :zipcode
      t.string :city
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :competing_clubs
  end
end
