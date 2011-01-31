class RegistrationDeadline < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  has_many :start_fees
  validates_presence_of :date
end
