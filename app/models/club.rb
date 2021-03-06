class Club < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :country
  has_many :club_members  
  has_many :competing_clubs
  has_many :events
  validates_presence_of :name
end
