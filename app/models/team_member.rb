class TeamMember < ActiveRecord::Base
  belongs_to :competitor
  belongs_to :team
end
