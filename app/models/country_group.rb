class CountryGroup < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  has_and_belongs_to_many :countries
  has_many :start_fees
end
