class Route < ApplicationRecord
  has_many :stop_stations
  has_many :favorites
  has_many :reviews
  has_many :spots

  include PgSearch::Model
  pg_search_scope :search_by_routes,
    against: [ :name, :code ],
    using: {
      tsearch: { prefix: true }
    }
end
