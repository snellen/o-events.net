class Result < ActiveRecord::Base
  belongs_to :chip
  validates_presence_of :chip
  has_many :split_times
  validates_numericality_of :start_time, :greater_than_or_equal_to => 0, :less_than => :finish_time, :only_integer => true
  validates_numericality_of :finish_time, :greater_than_or_equal_to => 0, :greater_than => :start_time, :only_integer => true
  validates_numericality_of :run_time, :greater_than => 0, :only_integer => true
  validates_numericality_of :rank, :greater_than => 0, :only_integer => true
end
