class Team < ActiveRecord::Base
  belongs_to :bill
  validates_presence_of :bill, :unless => "bill_id.blank?"
  belongs_to :competing_club
  validates_presence_of :competing_club 
  belongs_to :team_pool
  validates_presence_of :team_pool
  belongs_to :nation, :class_name => "Country"
  validates_presence_of :nation
  belongs_to :user
  validates_presence_of :user, :unless => "user_id.blank?"
  belongs_to :leader, :class_name => "Competitor"
  validates_presence_of :leader, :unless => "leader_id.blank?"
  
  has_many :competitors, :autosave => true
  has_many :team_registrations
  has_many :total_results

  validates_presence_of :name
  validates_presence_of :registration_time
  validates_inclusion_of :paid_by_club, :in => [true, false]
  validates_numericality_of :start_fee, :greater_than_or_equal_to => 0.0
  validates_inclusion_of :flag1, :in => [true, false], :unless => "flag1.blank?"
  validates_inclusion_of :flag2, :in => [true, false], :unless => "flag2.blank?"
  validates_inclusion_of :flag3, :in => [true, false], :unless => "flag3.blank?"
  validates_numericality_of :num1, :only_integer => true, :unless => "num1.blank?"
  validates_numericality_of :num2, :only_integer => true, :unless => "num2.blank?"
  validates_numericality_of :num3, :only_integer => true, :unless => "num3.blank?"
  
  # Adds a competitor to the team.
  # Defines the team leader if the team was empty, and sets a sortkey for the new competitor.
  def add_member(competitor)
    if @competitors.empty?
      @leader = competitor
      competitor.sortkey = 1
    else
      competitor.sortkey = @competitors.maximum(:sortkey)+1
    end
    @competitors << competitor
  end
  
  # Removes a competitor from the team and destroys it.
  def remove_member(competitor)
    competitor.destroy
    self.reload
    if @leader_id == competitor.id
      if @competitors.count == 1
        @leader = nil
      else
        @leader = TODO 
      end
    end
    
  end
end
