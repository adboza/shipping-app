class RenameTableShippingOrderToQuotation < ActiveRecord::Migration[7.0]
  def change
    rename_table('shipping_orders', 'quotations')
  end
end
