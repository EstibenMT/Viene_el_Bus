class AddEndHourToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :end_hour, :string
  end
end
