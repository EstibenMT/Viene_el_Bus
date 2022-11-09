class Spot < ApplicationRecord
  belongs_to :route
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_spots,
    against: [ :route_id ],
    using: {
      tsearch: { prefix: true }
    }
end
