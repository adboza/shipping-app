class AddShippingOrderRefToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_orders, :shipping_order, null: true, foreign_key: true
  end
end
