class AddRouteToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_reference :favorites, :route, null: false, foreign_key: true
  end
end
