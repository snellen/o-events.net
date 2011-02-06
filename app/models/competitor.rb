class Competitor < ActiveRecord::Base
  has_many :chips
  has_many :start_blocks
  has_many :start_times
  belongs_to :country
  validates_presence_of :country, :unless => "country_id.blank?"
  belongs_to :competing_club
  validates_presence_of :competing_club, :unless => "competing_club_id.blank?"
  belongs_to :nation, :class_name => "Country"
  validates_presence_of :nation
  belongs_to :user
  validates_presence_of :user, :unless => "user_id.blank?"
  belongs_to :team, :autosave => false
  validates_presence_of :team, :unless => "team_id.blank?"
  has_one :leader_team, :foreign_key => "leader_id"
  validates :email, :presence => true
  validates_format_of :email, :with => /(\S+)@(\S+)/
  validates :sex, :presence => true, :inclusion => {:in =>  %w( M F ), :allow_nil => true}
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :birthdate_y, :presence => true, :numericality => {:only_integer => true, :allow_nil => true}, :inclusion => {:in => 1900..Date.today.year, :allow_nil => true}
  validates :sortkey, :presence => true
  validates_inclusion_of :flag1, :in => [true, false], :unless => "flag1.blank?"
  validates_inclusion_of :flag2, :in => [true, false], :unless => "flag2.blank?"
  validates_inclusion_of :flag3, :in => [true, false], :unless => "flag3.blank?"
  validates_numericality_of :num1, :only_integer => true, :unless => "num1.blank?"
  validates_numericality_of :num2, :only_integer => true, :unless => "num2.blank?"
  validates_numericality_of :num3, :only_integer => true, :unless => "num3.blank?"
  
  
  # Provides a reader for the full name
  # Pass true to it to get an alphabetically sortable name
  def full_name(alpha = false)
    if alpha then
      last_name+', '+first_name
    else
      first_name+' '+last_name
    end
  end
  
  # Builds a Competitor and CompetingClub for the specified User and Club. (The TeamPool is needed to find existing CompetingClubs.)
  # The CompetingClub is saved immediately to avoid creating multiple CompetingClubs when saving multiple Competitors with the same club.
  def self.build_from_user(user,club,team_pool)
    attr = {:license_number => user.license_number, :region_code => user.region_code, :first_name => user.first_name, :last_name => user.last_name, :email => user.email, :phone => user.phone, :address_line_1 => user.address_line_1, :address_line_2 => user.address_line_2, :zipcode => user.zipcode, :city => user.city, :province => user.province, :sex => user.sex, :birthdate_y => user.birthdate_y, :birthdate_m => user.birthdate_m, :birthdate_d => user.birthdate_d, :country_id => user.country_id, :nation_id => user.nation_id, :user_id => user.id}
    #res = Competitor.where(:user_id => user.id).where(:team_id => team_pool.teams.map{|t| t.id})     
    #if res.empty?
    #  c = self.new(attr)
    #else
    #  c = res.first
    #  c.attributes = attr 
    #end
    c = self.new(attr)
    c.competing_club = CompetingClub.create_from_club(club,team_pool)
    c
  end
    
end
