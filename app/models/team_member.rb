class TeamMember < ActiveRecord::Base
  belongs_to :competitor
  validates_presence_of :competitor
  belongs_to :team
  validates_presence_of :team
  validates_inclusion_of :is_leader, :in => [true, false]
  validates_numericality_of :sortkey, :greater_than_or_equal_to => 0, :only_integer => true
end
