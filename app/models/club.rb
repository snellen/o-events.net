class Club < ActiveRecord::Base
  belongs_to :country
  has_many club_members
  has_many competing_clubs
end