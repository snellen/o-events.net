class StartFee < ActiveRecord::Base
  belongs_to :age_range
  belongs_to :category_group
  belongs_to :competition_group
  belongs_to :registration_deadline
  belongs_to :country_group
end
