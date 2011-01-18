class Category < ActiveRecord::Base
  belongs_to :competition
  belongs_to :category_group
end
