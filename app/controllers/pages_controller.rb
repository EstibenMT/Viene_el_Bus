class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @locations = Location.all
    marks(@locations)
  end

  private

  def marks(locations)
    @markers = locations.geocoded.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude
      }
    end
  end
end
