class TeamRegistration < ActiveRecord::Base
  belongs_to :team
  belongs_to :competition
  belongs_to :category
end
