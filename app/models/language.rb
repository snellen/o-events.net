class Language < ActiveRecord::Base
  has_and_belongs_to_many :events
  validates_presence_of :english_name
  validates_presence_of :native_name
  validates_presence_of :iso_code
end
