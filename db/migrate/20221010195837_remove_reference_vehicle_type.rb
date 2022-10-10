class RemoveReferenceVehicleType < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vehicle_types, :vehicle, foreign_key: true, index: false
  end
end
