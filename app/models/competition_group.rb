class CompetitionGroup < ActiveRecord::Base
  has_many :competitions
  has_many :categories
  has_many :start_fees
  has_many :teams
  has_and_belongs_to_many :additional_fees
  validates_presence_of :name
end
