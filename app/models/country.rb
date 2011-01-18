class Country < ActiveRecord::Base
  has_many :clubs
  has_many :competing_clubs
  has_many :competitors
  has_many :events
  has_many :users
end
