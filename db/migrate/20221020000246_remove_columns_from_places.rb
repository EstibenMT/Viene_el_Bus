class RemoveColumnsFromPlaces < ActiveRecord::Migration[7.0]
  def change
    remove_column :places, :longitude, :string
    remove_column :places, :latitude, :string
  end
end
