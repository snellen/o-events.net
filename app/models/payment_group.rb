class PaymentGroup < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  has_many :payments
  has_many :teams
end
