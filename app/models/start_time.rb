class StartTime < ActiveRecord::Base
  belongs_to :competitor
  belongs_to :run
end
