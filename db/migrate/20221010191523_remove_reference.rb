class RemoveReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vehicle_types, :delivery_modality, foreign_key: true, index: false
  end
end
