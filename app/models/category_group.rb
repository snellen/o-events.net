class CategoryGroup < ActiveRecord::Base
  has_many :categories
  has_many :start_fees
  validates_presence_of :fee_age_dependent
end
