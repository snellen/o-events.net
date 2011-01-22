class CountryGroup < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :countries
  has_many :start_fees
end
