class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy, :show]
  before_action :set_user, only: [:index, :create]
  before_action :set_route, only: [:indedx, :create]
  before_action :set_array_routes, only: [:index, :show ]
  def index
    @favorites = Favorite.all
    sugestions(@array_routes)
  end

  def show
    @favorite = Favorite.find(params[:id])
    sugestions(@array_routes)
  end

  def create
    @favorite = Favorite.new
    @favorite.mark_favourite = true
    @favorite.route = @route
    @favorite.user = current_user
    if @favorite.save!
      redirect_to favorites_path
    else
      render 'routes/show', status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end

  private

  def favorite_params
    params.require(:favorite).permit(:route_id, :user_id)
  end

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_route
    @route = Route.find(params[:route_id])
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
