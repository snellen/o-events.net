class Chip < ActiveRecord::Base
  belongs_to :run
  belongs_to :competitor
  has_one :result
end
