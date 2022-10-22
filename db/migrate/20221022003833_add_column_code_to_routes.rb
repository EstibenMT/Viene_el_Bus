class AddColumnCodeToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :code, :string
  end
end
