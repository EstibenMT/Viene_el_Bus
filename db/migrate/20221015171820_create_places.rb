class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
