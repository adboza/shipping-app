class CreateLoadCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :load_categories do |t|
      t.integer :min_weight
      t.integer :max_weight
      t.float :weight_dist_price

      t.timestamps
    end
  end
end
