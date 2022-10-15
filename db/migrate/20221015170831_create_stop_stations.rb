class CreateStopStations < ActiveRecord::Migration[7.0]
  def change
    create_table :stop_stations do |t|
      t.string :station_name
      t.string :longitude
      t.string :latitude
      t.integer :previous_station
      t.integer :next_station

      t.timestamps
    end
  end
end
