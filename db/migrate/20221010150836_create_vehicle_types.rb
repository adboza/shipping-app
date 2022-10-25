class CreateVehicleTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicle_types do |t|
      t.references :delivery_modality, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
