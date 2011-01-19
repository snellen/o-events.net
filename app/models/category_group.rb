class CategoryGroup < ActiveRecord::Base
  belongs_to :competition_group
  has_many :categories
  has_many :start_fees
end
