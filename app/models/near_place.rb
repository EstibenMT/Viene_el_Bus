class NearPlace < ApplicationRecord
  belongs_to :place
  belongs_to :stop_station
end
