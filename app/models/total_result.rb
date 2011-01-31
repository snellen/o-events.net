class TotalResult < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team
  belongs_to :competition
  validates_presence_of :competition
  validates_numericality_of :total_time, :greater_than => 0, :only_integer => true
  validates_numericality_of :score, :greater_than_or_equal_to => 0, :only_integer => true
  validates_numericality_of :rank, :greater_than => 0, :only_integer => true
end
