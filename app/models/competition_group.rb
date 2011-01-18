class CompetitionGroup < ActiveRecord::Base
  has_many :competitions
  has_many :category_groups
end
