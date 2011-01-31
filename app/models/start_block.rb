class StartBlock < ActiveRecord::Base
  belongs_to :competitor
  validates_presence_of :competitor
  belongs_to :run
  validates_presence_of :run
  validates_numericality_of :start_block, :greater_than => 0, :only_integer => true
end
