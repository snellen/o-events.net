class Competition < ActiveRecord::Base
  belongs_to :event
  belongs_to :competition_group
  has_many :team_registrations
  has_many :runs
  has_many :total_results
end
