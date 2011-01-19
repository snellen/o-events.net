class RegistrationDeadline < ActiveRecord::Base
  belongs_to :event
  has_many :start_Fees
end
