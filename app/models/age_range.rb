class AgeRange < ActiveRecord::Base
  belongs_to :event
  has_many :start_fees
  has_many :additional_fees
end
