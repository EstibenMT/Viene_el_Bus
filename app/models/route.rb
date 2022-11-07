class Route < ApplicationRecord
  has_many :stop_stations
  has_many :favorites
  has_many :reviews, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :hours, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_routes,
    against: [ :name, :code ],
    using: {
      tsearch: { prefix: true }
    }
end
