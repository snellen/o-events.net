class StartFee < ActiveRecord::Base
  belongs_to :age_range
  validates_presence_of :age_range, :unless => "age_range_id.blank?"
  belongs_to :category_group
  validates_presence_of :category_group, :unless => "category_id.blank?"
  belongs_to :competition_group
  validates_presence_of :competition_group
  belongs_to :registration_deadline
  validates_presence_of :registration_deadline
  belongs_to :country_group
  validates_presence_of :country_group, :unless => "country_group_id.blank?"
  validates_numericality_of :amount, :greater_than_or_equal_to => 0.0
end
