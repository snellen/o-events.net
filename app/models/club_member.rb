class ClubMember < ActiveRecord::Base
  belongs_to :club
  belongs_to :user
end
