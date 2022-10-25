class RemoveReferenceVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vehicles, :vehicle_type, foreign_key: true, index: false
  end
end
