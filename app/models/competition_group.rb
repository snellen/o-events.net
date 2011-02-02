class CompetitionGroup < ActiveRecord::Base
  belongs_to :team_pool
  validates_presence_of :team_pool_id, :unless => "team_pool_id.blank?"
  has_many :competitions
  has_many :start_fees
  has_many :additional_fees
end
