class Event < ActiveRecord::Base
  belongs_to :club
  validates_presence_of :club
  belongs_to :country
  validates_presence_of :country
  belongs_to :currency
  validates_presence_of :currency 
  has_many :additional_fees
  has_many :age_ranges
  has_many :competitions
  has_many :competitors
  has_many :users, :through => :competitors
  has_many :country_groups
  has_many :registration_deadlines
  has_and_belongs_to_many :languages
  validates_presence_of :name
  validates_presence_of :start_date
  #validates :start_date, :date => { :after => Time.now, :before_or_equal_to => :end_date }
  validates_presence_of :end_date
  #validates :end_date, :date => { :after_or_equal_to => :start_date }
  validates_presence_of :slug
  validates_format_of :slug, :with => /[a-z0-9]/i
end
