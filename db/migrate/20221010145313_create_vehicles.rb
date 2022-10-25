class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :licence_plate
      t.date :year
      t.integer :load_capacity

      t.timestamps
    end
  end
end
