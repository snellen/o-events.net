class Bill < ActiveRecord::Base
  has_many :additional_bill_informations
  has_many :payments
  has_many :teams
  belongs_to :user
  belongs_to :country
  
  validates_presence_of :user
  validates_presence_of :country
  validates_numericality_of :exchange_rate, :greater_than => 0
  validates_inclusion_of :is_paper_bill, :in => [true, false]
  validates_inclusion_of :is_paper_bill_sent, :in => [true, false]
  validates_inclusion_of :is_paid, :in => [true, false]
  validates_presence_of :reference_number
  validates_format_of :reference_number, :with => /[0-9]+/
  validates_uniqueness_of :reference_number
  validates_presence_of :first_name
  validates_length_of :first_name, :minimum => 1
  validates_presence_of :last_name
  validates_length_of :last_name, :minimum => 1
  validates_presence_of :address_line_1
  validates_length_of :address_line_1, :minimum => 1
  validates_presence_of :city
  validates_length_of :city, :minimum => 1
  validates_presence_of :zipcode
  validates_length_of :zipcode, :minimum => 1

  attr_protected :exchange_rate, :is_paper_bill, :is_paper_bill_sent, :is_paid, :reference_number
  
  # Amount in event currency
  def amount
    sum = BigDecimal.new("0.0")
    teams.each{|t| sum += t.start_fee}
    sum
  end
    
  # Amount in CHF
  def amountInCHF
    (amount*exchange_rate).round(2,BigDecimal::ROUND_UP)
  end
  
  def currency
    event.currency
  end
  
  def event
    teams[0].team_pool.event
  end
  
  # Returns the creation date of the newest payment, or nil if bill is not paid yet
  def paid_at
    if !is_paid
      return nil
    end
    ps = payments.order('created_at DESC').limit(1)
    ps.first.created_at 
  end
end
