class AddReferenceVehicle < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :vehicle_type, foreign_key: true
  end
end
