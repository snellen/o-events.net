class AgeRange < ActiveRecord::Base
  belongs_to :event
  has_many :additional_fees
end
