class Nation < ActiveRecord::Base
  has_many :competitors
  has_many :users
  has_and_belongs_to_many :nation_groups
end
