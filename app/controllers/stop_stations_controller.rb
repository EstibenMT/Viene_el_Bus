class StopStationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @stop_stations = StopStation.all
    @markers = @stop_stations.geocoded.map do |stop_station|
      {
        latitude: stop_station.latitude,
        longitude: stop_station.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { stop_station: stop_station })
      }
    end
  end
end
