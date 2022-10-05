class AddDeliveryModalityRefToLoadCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :load_categories, :delivery_modality, null: false, foreign_key: true
  end
end
