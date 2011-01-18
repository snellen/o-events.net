class CompetingClub < ActiveRecord::Base
  belongs_to :country
  belongs_to :club
  has_many :competitors
end
