class Competition < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  belongs_to :competition_group
  validates_presence_of :competition_group, :unless => "competition_group_id.blank?" 
  has_many :team_registrations
  has_many :runs
  has_many :total_results
  validates_presence_of :name
  validates_presence_of :kind
  validates_inclusion_of :kind, :in => %w(single relay team)
end
