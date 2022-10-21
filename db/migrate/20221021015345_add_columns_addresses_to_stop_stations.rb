class AddColumnsAddressesToStopStations < ActiveRecord::Migration[7.0]
  def change
    add_column :stop_stations, :city, :string
    add_column :stop_stations, :department, :string
    add_column :stop_stations, :country, :string
  end
end
