class CompetingClub < ActiveRecord::Base
  belongs_to :country
  belongs_to :club
end
