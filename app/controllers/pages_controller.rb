class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_array_routes, only: [:home]
  def home
    @locations = Location.all
    marks(@locations)
    sugestions(@array_routes)
  end

  private

  def set_array_routes
    @array_routes = Route.all
  end

  def marks(locations)
    @markers = locations.geocoded.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude
      }
    end
  end

  def sugestions(array_routes)
    @sugestions = array_routes.map do |route|
      route.name
    end
  end
end
