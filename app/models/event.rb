class Event < ActiveRecord::Base
  belongs_to :club
  belongs_to :country
  belongs_to :currency
  has_many :additional_fees
  has_many :age_ranges
  has_many :competitions
  has_many :competitors
  has_many :nation_groups
  has_many :registration_deadlines
  has_and_belongs_to_many :languages
end
