class CreateStopTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :stop_times do |t|
      t.string :hour

      t.timestamps
    end
  end
end
