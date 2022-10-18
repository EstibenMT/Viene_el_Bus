class AddStopStationToNearPlaces < ActiveRecord::Migration[7.0]
  def change
    add_reference :near_places, :stop_station, null: false, foreign_key: true
  end
end
