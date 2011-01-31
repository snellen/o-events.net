class TeamRegistration < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team
  belongs_to :competition
  validates_presence_of :competition
  belongs_to :category
  validates_presence_of :category
end
