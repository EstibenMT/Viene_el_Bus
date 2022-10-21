class AddColumnsAddressesToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :city, :string
    add_column :places, :department, :string
    add_column :places, :country, :string
  end
end
