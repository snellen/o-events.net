class CategoryGroup < ActiveRecord::Base
  has_many :categories
  has_many :start_fees
end
