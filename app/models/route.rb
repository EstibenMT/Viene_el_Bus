class Route < ApplicationRecord
  has_many :stop_stations
  has_many :favorites
  has_many :reviews

  include PgSearch::Model
  pg_search_scope :search_by_routes,
    against: [ :name, :code ],
    associated_against: {
      stop_stations: [ :station_name, :address ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
