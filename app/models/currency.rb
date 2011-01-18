class Currency < ActiveRecord::Base
  has_many :events
end
