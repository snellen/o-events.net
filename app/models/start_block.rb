class StartBlock < ActiveRecord::Base
  belongs_to :competitor
  belongs_to :run
end
