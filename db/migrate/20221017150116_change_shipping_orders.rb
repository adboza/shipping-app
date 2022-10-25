class CreateShippingOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_orders do |t|
      t.datetime :received_date
      t.datetime :estimated_delivery_date
      t.string :late_comments
      t.references :quotation, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
