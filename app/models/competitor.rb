class Competitor < ActiveRecord::Base
  has_many :chips
  has_many :start_blocks
  has_many :start_times
  has_many :team_members
  belongs_to :country
  belongs_to :competing_club
  belongs_to :country
  belongs_to :event
  belongs_to :user
end
