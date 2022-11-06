class RoutesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_route, only: [:show]
  before_action :set_stop_station, only: [:show]
  def index
    if params[:query].present?
      @routes = Route.search_by_routes(params[:query])
    else
      @routes = []
    end
    @locations = Location.all
    marks(@locations)
  end

  def show
    marks(@stop_stations)
    if user_signed_in?
      @mark_favourite = Favorite.where(user_id: current_user.id, route_id: @route.id)
    else
      @mark_favourites = []
      @mark_favourites << Favorite.new
    end
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def set_stop_station
    @stop_stations = StopStation.search_by_routes(@route.id)
  end

  def marks(locations)
    @markers = locations.geocoded.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { location: location })
      }
    end
  end

  def query_routes(routes)
    @query_routes = routes.map do |route|
      {
        name: route.name,
        code: route.code,
        price: route.price
      }
    end
  end
end
