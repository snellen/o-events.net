class SplitTime < ActiveRecord::Base
  belongs_to :result
  validates_presence_of :result
  validates_numericality_of :control_number, :greater_than => 0, :less_than => 1024, :only_integer => true
  validates_numericality_of :split_time, :greater_than => 0, :only_integer => true
end
