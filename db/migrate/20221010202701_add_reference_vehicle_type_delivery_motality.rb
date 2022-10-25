class AddReferenceVehicleTypeDeliveryMotality < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicle_types, :delivery_modality, foreign_key: true
  end
end
