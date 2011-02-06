class CompetingClub < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :country
  belongs_to :club
  validates_presence_of :club, :unless => "club_id.blank?"
  has_many :competitors
  has_many :teams
  validates_presence_of :name
  
  # Creates a CompetingClub in the database for the specified Club, unless it exists already in the specified TeamPool
  def self.create_from_club(club,team_pool)
    attr = {:name => club.name, :address_line_1 => club.address_line_1, :address_line_2 => club.address_line_2, :zipcode => club.zipcode, :city => club.city, :website => club.website, :country_id => club.country_id, :club_id => club.id}
    competitors = Competitor.where(:team_id => team_pool.teams.map{|t| t.id})
    res = club.competing_clubs.where(:id => competitors.map{|c| c.competing_club_id})
    if res.empty?
      cc = self.new(attr)
    else
      cc = res.first
      cc.attributes = attr
    end
    cc.save
    cc    
  end
end
