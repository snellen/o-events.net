class CompetingClub < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :country
  belongs_to :club
  validates_presence_of :club
  has_many :competitors
  validates_presence_of :name
end
