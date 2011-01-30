class AgeRange < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  has_many :start_fees
  has_many :additional_fees
  validates_numericality_of :lower, :less_than => :higher, :greater_than => 0, :only_integer => true
  validates_numericality_of :higher, :less_than => 100, :greater_than => :lower, :only_integer => true
end
