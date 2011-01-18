class Competitor < ActiveRecord::Base
  has_many :chips
  belongs_to :country
  belongs_to :nation
  belongs_to :event
end
