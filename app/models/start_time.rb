class StartTime < ActiveRecord::Base
  belongs_to :competitor
  validates_presence_of :competitor
  belongs_to :run
  validates_presence_of :run
  validates_numericality_of :start_time, :greater_than_or_equal_to => 0, :only_integer => true
end
