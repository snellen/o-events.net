class CompetitionGroup < ActiveRecord::Base
  has_many :competitions
  has_many :categories
  has_many :start_fees
  has_many :teams
end
