class RenameTableSippingOrderToQuotation < ActiveRecord::Migration[7.0]
  def change
    rename_table('sipping_orders', 'quotations')
  end
end
