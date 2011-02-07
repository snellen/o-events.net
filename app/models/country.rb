class Country < ActiveRecord::Base
  has_many :clubs
  has_many :competing_clubs
  has_many :competitors
  has_many :users
  has_many :bills
  has_many :events
  has_many :citizens, :class_name => "User", :foreign_key => "nation_id"
  has_many :representatives, :class_name => "Competitor", :foreign_key => "nation_id"
  has_and_belongs_to_many :country_groups
  validates_presence_of :name
  validates_presence_of :iso_code
  validates_presence_of :ioc_code
end
