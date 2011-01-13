class CreateCompetitors < ActiveRecord::Migration
  def self.up
    create_table :competitors do |t|
      t.string :license_number
      t.string :region_code
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address_line_1
      t.string :address_line_2
      t.string :zipcode
      t.string :city
      t.string :province
      t.string :sex
      t.integer :birthdate_y
      t.integer :birthdate_m
      t.integer :birthdate_d

      t.timestamps
    end
  end

  def self.down
    drop_table :competitors
  end
end
