class Place < ApplicationRecord
  has_many :near_places
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
