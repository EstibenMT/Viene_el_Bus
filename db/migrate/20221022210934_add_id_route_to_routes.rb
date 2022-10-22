class AddIdRouteToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :id_route, :string
  end
end
