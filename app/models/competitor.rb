class Competitor < ActiveRecord::Base
  has_many :chips
  has_many :start_blocks
  has_many :start_times
  has_many :team_members
  belongs_to :country
  validates_presence_of :country, :unless => "country_id.blank?"
  belongs_to :competing_club
  validates_presence_of :competing_club, :unless => "competing_club_id.blank?"
  belongs_to :nation, :class_name => "Country"
  validates_presence_of :nation
  belongs_to :event
  validates_presence_of :event
  belongs_to :user
  validates_presence_of :user
  validates :username, :presence => true
  validates :email, :presence => true
  validates_format_of :email, :with => /(\S+)@(\S+)/
  validates :sex, :presence => true, :inclusion => {:in =>  %w( M F ), :allow_nil => true}
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :birthdate_y, :presence => true, :numericality => {:only_integer => true, :allow_nil => true}, :inclusion => {:in => 1900..Date.today.year, :allow_nil => true}
  validates :sicard_number, :numericality => {:only_integer => true, :allow_nil => true}, :inclusion => {:in => 1..16777216, :allow_nil => true}
  validates_inclusion_of :flag1, :in => [true, false], :unless => "flag1.blank?"
  validates_inclusion_of :flag2, :in => [true, false], :unless => "flag2.blank?"
  validates_inclusion_of :flag3, :in => [true, false], :unless => "flag3.blank?"
  validates_numericality_of :num1, :only_integer => true, :unless => "num1.blank?"
  validates_numericality_of :num2, :only_integer => true, :unless => "num2.blank?"
  validates_numericality_of :num3, :only_integer => true, :unless => "num3.blank?"
end
