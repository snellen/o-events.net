class Category < ActiveRecord::Base
  belongs_to :competition_group
  belongs_to :category_group
  has_many :team_registrations
end
