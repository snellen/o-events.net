class Bill < ActiveRecord::Base
  has_many :payments
  has_many :teams
 
  #TODO: validations
  
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
    for team in teams.each do
      eventOfTeam = team.team_pool.event.id
      if eventId < 0
        eventId = eventOfTeam
      end
      if eventId != eventOfTeam
        raise "Teams in bill inconsistent!"
      end
    end
  end  
end
