class CreateDistanceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_categories do |t|
      t.references :delivery_modality, null: false, foreign_key: true
      t.decimal :distance_price
      t.integer :min_distance
      t.integer :max_distance

      t.timestamps
    end
  end
end
