class CreateVehicleTypeSelections < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicle_type_selections do |t|
      t.references :delivery_modality, null: false, foreign_key: true
      t.references :vehicle_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
