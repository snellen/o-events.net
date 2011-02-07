class Bill < ActiveRecord::Base
  has_many :payments
  has_many :teams
  belongs_to :user
  belongs_to :country
 
  #TODO: validations
  
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
