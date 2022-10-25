class RemoveAttributesFromQuotation < ActiveRecord::Migration[7.0]
  def change
    remove_reference(:quotations, :vehicle, foreign_key: true)
    remove_columns(:quotations, :status, :estim_delivery_date, :received_date, :late_comments)
  end
end
