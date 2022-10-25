class RoutesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    if params[:query].present?
      @stop_stations = StopStation.search_by_routes(params[:query])
    else
      @stop_stations = StopStation.all
    end
    marks(@stop_stations)
  end

  def show
    @route = Route.find(params[:id])
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
