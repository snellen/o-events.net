class Team < ActiveRecord::Base
  belongs_to :payment_group
  belongs_to :category
  has_many :team_members
  has_many :total_results
end
