class Run < ActiveRecord::Base
  belongs_to :competition
  has_many :chips
  has_many :start_blocks
  has_many :start_times
end
