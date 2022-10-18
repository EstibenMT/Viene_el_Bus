class AddStopStationToStopTimes < ActiveRecord::Migration[7.0]
  def change
    add_reference :stop_times, :stop_station, null: false, foreign_key: true
  end
end
