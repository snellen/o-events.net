class CategoryGroup < ActiveRecord::Base
  has_many :categories
  has_many :start_fees
  validates_inclusion_of :fee_age_dependent, :in => [true, false]
end
