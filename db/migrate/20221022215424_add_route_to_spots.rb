class AddRouteToSpots < ActiveRecord::Migration[7.0]
  def change
    add_reference :spots, :route, null: false, foreign_key: true
  end
end
