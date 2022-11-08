class AddMarkFavouriteToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :mark_favourite, :boolean
  end
end
