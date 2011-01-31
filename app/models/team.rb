class Team < ActiveRecord::Base
  belongs_to :payment_group
  belongs_to :competing_club
  validates_presence_of :competing_club 
  belongs_to :competition_group
  validates_presence_of :competition_group
  belongs_to :country
  validates_presence_of :country
  has_many :team_members
  has_many :team_registrations
  has_many :total_results
  validates_presence_of :name
  validates_presence_of :registration_time
  validates_inclusion_of :paid_by_club, :in => [true, false]
  validates_numericality_of :start_fee, :greater_than_or_equal_to => 0.0
  validates_inclusion_of :is_paid, :in => [true, false]
  validates_inclusion_of :flag1, :in => [true, false], :unless => "flag1.blank?"
  validates_inclusion_of :flag2, :in => [true, false], :unless => "flag2.blank?"
  validates_inclusion_of :flag3, :in => [true, false], :unless => "flag3.blank?"
  validates_numericality_of :num1, :only_integer => true, :unless => "num1.blank?"
  validates_numericality_of :num2, :only_integer => true, :unless => "num2.blank?"
  validates_numericality_of :num3, :only_integer => true, :unless => "num3.blank?"
end
