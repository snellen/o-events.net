class Country < ActiveRecord::Base
  has_many :clubs
  has_many :competing_clubs
  has_many :competitors
end
