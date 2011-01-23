class AdditionalFee < ActiveRecord::Base
  belongs_to :event
  belongs_to :age_range
  has_and_belongs_to_many :competition_groups
end
