class StopStation < ApplicationRecord
  has_many :stop_times
  has_many :near_places
  belongs_to :route
end
