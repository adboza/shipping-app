class ChangeColumnNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:sipping_orders, :vehicle_id, true)
    change_column_null(:sipping_orders, :load_category_id, true)
    change_column_null(:sipping_orders, :distance_category_id, true)
  end
end
