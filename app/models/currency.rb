class Currency < ActiveRecord::Base
  has_many :events
  validates_presence_of :name
  validates_presence_of :iso_code
end
