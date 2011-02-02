class CompetingClub < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :country
  belongs_to :club
  validates_presence_of :club, :unless => "club_id.blank?"
  has_many :competitors
  has_many :teams
  validates_presence_of :name
end
