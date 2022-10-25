class AddSippingOrderRefToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_orders, :sipping_order, null: true, foreign_key: true
  end
end
