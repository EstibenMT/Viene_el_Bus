class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if params[:query].present?
      @stop_stations = StopStation.search_by_routes(params[:query])
    else
      @stop_stations = StopStation.all
    end
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
#  if hay_busqueda
#   marjkers = hay_busqueda
#  else
#   marjkers = [latitude, longitude]Medellin
#  end
