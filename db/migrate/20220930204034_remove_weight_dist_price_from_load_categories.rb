class RemoveWeightDistPriceFromLoadCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :load_categories, :weight_dist_price, :float
  end
end
