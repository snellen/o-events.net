class Result < ActiveRecord::Base
  belongs_to :chip
  has_many :split_times
end
