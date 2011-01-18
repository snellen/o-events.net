class Event < ActiveRecord::Base
  has_many :additional_fees
  has_many :age_ranges
  has_many :competitions
  has_many :competitors
end
