class CategoryGroup < ActiveRecord::Base
  belongs_to :competition_group
  has_many :categories
end
