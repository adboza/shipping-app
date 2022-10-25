class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :tracking_code
      t.string :departure_address
      t.string :delivery_address
      t.string :comments
      t.integer :shipping_distance
      t.integer :goods_weight

      t.timestamps
    end
  end
end
