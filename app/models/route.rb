class Route < ApplicationRecord
  has_many :stop_stations
  has_many :favorites
  has_many :reviews

end
