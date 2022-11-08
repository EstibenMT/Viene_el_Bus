class AddStartHourToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :start_hour, :string
  end
end
