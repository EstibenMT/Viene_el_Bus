class AddImageToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :image, :string
  end
end
