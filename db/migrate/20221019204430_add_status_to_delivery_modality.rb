class AddStatusToDeliveryModality < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_modalities, :status, :integer, default: 0
  end
end
