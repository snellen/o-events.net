class AdditionalFee < ActiveRecord::Base
  belongs_to :event
  belongs_to :age_range
end
