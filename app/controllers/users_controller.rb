class UsersController < ApplicationController
  before_action :set_array_routes, only: [:show]

  def show
    @user = User.find(params[:id])
    sugestions(@array_routes)
  end

  def set_array_routes
    @array_routes = Route.all
  end

  def sugestions(array_routes)
    @sugestions = array_routes.map do |route|
      route.name
    end
  end
end
