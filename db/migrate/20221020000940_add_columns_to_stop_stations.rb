class AddColumnsToStopStations < ActiveRecord::Migration[7.0]
  def change
    add_column :stop_stations, :longitude, :float
    add_column :stop_stations, :latitude, :float
    add_column :stop_stations, :address, :string
  end
end
