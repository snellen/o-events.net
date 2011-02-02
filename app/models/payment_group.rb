class PaymentGroup < ActiveRecord::Base
  has_many :payments
  has_many :teams
end
