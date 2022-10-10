class AddDeliveryTimeToDistanceCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :distance_categories, :delivery_time, :integer
  end
end
