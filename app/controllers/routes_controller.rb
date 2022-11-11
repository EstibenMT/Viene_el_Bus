class RoutesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_route, only: [:show]
  before_action :set_stop_station, only: [:show]
  before_action :set_array_routes, only: [:index, :show]
  before_action :set_spots, only: [:show]
  before_action :set_array_routes, only: [:show, :index]


  def index

    if params[:query].present?
      @routes = Route.search_by_routes(params[:query])
    else
      @routes = []
    end
    @locations = Location.all
    not_marks(@locations)
    sugestions(@array_routes)
  end

  def show
    marks(@stop_stations)
    line_spots(@spots)
    sugestions(@array_routes)
    if user_signed_in?
      @mark_favourite = Favorite.where(user_id: current_user.id, route_id: @route.id)
    else
      @mark_favourite = []
      @mark_favourite << Favorite.new
    end
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def set_stop_station
    @stop_stations = StopStation.search_by_routes(@route.id)
  end

  def set_spots
    @spots = Spot.search_by_spots(@route.id)
  end

  def set_array_routes
    @array_routes = Route.all
  end

  def not_marks(locations)
    @markers = locations.geocoded.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude
      }
    end
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

  def line_spots(spots)
    @lines = spots.geocoded.map do |spot|
      [spot.longitude, spot.latitude]
    end
  end

  def sugestions(array_routes)
    @sugestions = array_routes.map do |route|
      route.name
    end
  end
end
