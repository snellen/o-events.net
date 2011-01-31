class ClubMember < ActiveRecord::Base
  belongs_to :club
  validates_presence_of :club
  belongs_to :user
  validates_presence_of :user
  validates_inclusion_of :is_default, :in => [true, false]
end
