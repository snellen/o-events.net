class Category < ActiveRecord::Base
  belongs_to :team_pool
  validates_presence_of :team_pool
  belongs_to :category_group
  validates_presence_of :category_group, :unless => "category_group_id.blank?"
  has_many :team_registrations
  validates_presence_of :name
  validates_format_of :slug, :with => /[a-z0-9]/i
  validates_numericality_of :min_age, :less_than => :max_age, :greater_than_or_equal_to => 0, :only_integer => true
  validates_numericality_of :max_age, :less_than => 100, :greater_than => :min_age, :only_integer => true
  validates_inclusion_of :sex, :in => %w(M F O)
  validates_numericality_of :min_team_size, :less_than_or_equal_to => :max_team_size, :greater_than => 0, :only_integer => true
  validates_numericality_of :max_team_size, :greater_than_or_equal_to => :min_team_size , :only_integer => true
end
