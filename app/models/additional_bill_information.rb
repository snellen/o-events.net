class AdditionalBillInformation < ActiveRecord::Base
  belongs_to :bill
  validates_presence_of :bill
  validates_presence_of :name
end
