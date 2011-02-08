class Bill < ActiveRecord::Base
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
  
  def amount
    check_teams
    sum = 0
    teams.sum(:start_fee)
  end
  
  def currency
    event.currency
  end
  
  def event
    check_teams
    teams[0].team_pool.event
  end
      
  private
  # Check if there is one or more teams (of the same event) in this bill
  def check_teams
    raise "Bill has no teams!" unless teams.size > 0
    eventId = -1
    userId = -1
    for team in teams.each do
      eventOfTeam = team.team_pool.event.id
      userOfTeam = team.user.id
      if eventId < 0
        eventId = eventOfTeam
      end
      if userId < 0
             userId = userOfTeam
      end
      if eventId != eventOfTeam
        raise "Teams in bill inconsistent!"
      end
      if userId != userOfTeam
        raise "User of teams in bill inconsistent!"
      end
    end
  end  
end
