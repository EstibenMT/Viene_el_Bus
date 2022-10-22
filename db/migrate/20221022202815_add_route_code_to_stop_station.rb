class AddRouteCodeToStopStation < ActiveRecord::Migration[7.0]
  def change
    add_column :stop_stations, :route_code, :string
  end
end
