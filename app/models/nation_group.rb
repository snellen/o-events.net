class NationGroup < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :nations
  has_many :start_fees
end
