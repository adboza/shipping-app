class AddLoadCategoryRefToShippingOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :shipping_orders, :load_category, null: false, foreign_key: true
    add_reference :shipping_orders, :distance_category, null: false, foreign_key: true
  end
end
