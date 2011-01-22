class Club < ActiveRecord::Base
  belongs_to :country
  has_many :club_members
  has_many :users, :through => :club_members  
  has_many :competing_clubs
  has_many :events
end
