class AddRouteToStopStations < ActiveRecord::Migration[7.0]
  def change
    add_reference :stop_stations, :route, null: false, foreign_key: true
  end
end
