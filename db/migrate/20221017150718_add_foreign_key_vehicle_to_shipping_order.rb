class AddForeignKeyVehicleToShippingOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :shipping_orders, :vehicles, null: true
  end
end
