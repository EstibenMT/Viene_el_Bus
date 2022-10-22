class StopStation < ApplicationRecord
  has_many :stop_times
  has_many :near_places
  belongs_to :route
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  scope :route_stations, ->(route) { where("route_id=?", route.id) }
end
