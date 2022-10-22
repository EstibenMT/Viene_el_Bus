class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

  def show
    @favorite = Favorite.find(params[:id])
  end

  def create
    ruta_id = params[:id]
    @favorite = Favorite.new(route_id: ruta_id, user_id: current_user.id)
    @favorite.save!
  end

  def delete
    @favorite = Favorite.find()
  end
end
