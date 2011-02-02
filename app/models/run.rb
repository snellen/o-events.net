class Run < ActiveRecord::Base
  belongs_to :competition
  validates_presence_of :competition
  has_many :chips
  has_many :start_blocks
  has_many :start_times
  validates_presence_of :name
  validates_numericality_of :sortkey, :greater_than => 0, :only_integer => true
  validates_numericality_of :age_limit_1, :greater_than => 0, :less_than => 100, :only_integer => true
  validates_numericality_of :age_limit_2, :greater_than => 0, :less_than => 100, :only_integer => true
end
