class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @stop_stations = StopStation.all
    marks(@stop_stations)
  end

  private

  def marks(stop_stations)
    @markers = stop_stations.geocoded.map do |stop_station|
      {
        latitude: stop_station.latitude,
        longitude: stop_station.longitude
      }
    end
  end
end
