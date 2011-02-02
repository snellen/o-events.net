class TeamPool < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  has_many :teams
  has_many :competition_groups
  has_many :categories
  validates_presence_of :name
end
