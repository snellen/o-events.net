class Team < ActiveRecord::Base
  belongs_to :payment_group
  belongs_to :competing_club
  belongs_to :competition_group
  belongs_to :nation
  has_many :team_members
  has_many :team_registrations
  has_many :total_results
end
