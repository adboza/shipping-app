class CreateSippingOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :sipping_orders do |t|
      t.references :delivery_modality, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.integer :status
      t.datetime :received_date
      t.datetime :estim_delivery_date
      t.string :late_comments

      t.timestamps
    end
  end
end
