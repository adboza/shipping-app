class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :vehicle_types, :status, :vehicle_type    
  end
end
