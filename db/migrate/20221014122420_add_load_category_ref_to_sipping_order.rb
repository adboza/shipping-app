class AddLoadCategoryRefToSippingOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :sipping_orders, :load_category, null: false, foreign_key: true
    add_reference :sipping_orders, :distance_category, null: false, foreign_key: true
  end
end
