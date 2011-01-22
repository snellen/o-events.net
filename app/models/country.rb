class Country < ActiveRecord::Base
  has_many :clubs
  has_many :competing_clubs
  has_many :competitors
  has_many :events
  has_many :residents, :class_name => "Users"
  has_many :representatives, :class_name => "Users"
  has_and_belongs_to_many :country_groups
end
