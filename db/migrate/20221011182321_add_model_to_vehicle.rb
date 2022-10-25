class AddModelToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :model, :string
  end
end
