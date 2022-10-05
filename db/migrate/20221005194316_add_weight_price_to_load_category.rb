class AddWeightPriceToLoadCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :load_categories, :weight_price, :decimal
  end
end
