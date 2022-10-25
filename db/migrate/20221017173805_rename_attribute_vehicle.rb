class RenameAttributeVehicle < ActiveRecord::Migration[7.0]
  def change
    rename_column :shipping_orders, :vehicles_id, :vehicle_id 
  end
end
