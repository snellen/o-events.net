class Currency < ActiveRecord::Base
  has_many :events
  has_many :payments
  validates_presence_of :name
  validates_presence_of :iso_code
end
