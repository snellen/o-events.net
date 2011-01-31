class Payment < ActiveRecord::Base
  belongs_to :payment_group
  validates_presence_of :payment_group
  belongs_to :currency
  validates_presence_of :valuta
  validates_presence_of :fees_valuta
  validates_presence_of :currency
  validates_presence_of :reference_number
  validates_presence_of :registration_time
  validates_presence_of :method
  validates_inclusion_of :method, :in => %w(esr postfinance_card postfinance_efinance paypal)
  validates_presence_of :fees
  validates_numericality_of :fees, :greater_than_or_equal_to => 0.0
  validates_presence_of :fees_included
  validates_inclusion_of :fees_included, :in => [true, false]
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than_or_equal_to => 0.0
end
