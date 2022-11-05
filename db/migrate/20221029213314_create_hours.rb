class CreateHours < ActiveRecord::Migration[7.0]
  def change
    create_table :hours do |t|
      t.time :hour
      t.references :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
