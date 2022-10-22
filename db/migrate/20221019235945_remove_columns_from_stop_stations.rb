class RemoveColumnsFromStopStations < ActiveRecord::Migration[7.0]
  def change
    remove_column :stop_stations, :longitude, :string
    remove_column :stop_stations, :latitude, :string
  end
end
