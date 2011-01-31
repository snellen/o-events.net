class AdditionalFee < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  belongs_to :age_range
  validates_presence_of :age_range, :unless => "age_range_id.blank?"
  has_and_belongs_to_many :competition_groups
  validates_presence_of :name
  validates_numericality_of :amount, :greater_than_or_equal_to => 0.0
end
