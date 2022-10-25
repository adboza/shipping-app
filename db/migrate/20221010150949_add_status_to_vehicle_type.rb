class AddStatusToVehicleType < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicle_types, :status, :integer, default: 0
  end
end
