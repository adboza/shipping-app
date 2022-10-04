class CreateDeliveryModalities < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_modalities do |t|
      t.string :mod_name
      t.decimal :mod_price

      t.timestamps
    end
  end
end
