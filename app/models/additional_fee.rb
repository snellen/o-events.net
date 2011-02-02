class AdditionalFee < ActiveRecord::Base
  belongs_to :competition_group
  validates_presence_of :competition_group
  belongs_to :age_range
  validates_presence_of :age_range, :unless => "age_range_id.blank?"
  validates_presence_of :name
  validates_numericality_of :amount, :greater_than_or_equal_to => 0.0
end
