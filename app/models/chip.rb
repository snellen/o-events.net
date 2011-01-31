class Chip < ActiveRecord::Base
  belongs_to :run
  validates_presence_of :run
  belongs_to :competitor
  validates_presence_of :competitor
  has_one :result
  validates_presence_of :number
  validates_numericality_of :number, :greater_than_or_equal_to => 0, :only_integer => true 
end
