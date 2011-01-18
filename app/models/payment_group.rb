class PaymentGroup < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  has_many :teams
end
