class VehicleTypeSelection < ApplicationRecord
  belongs_to :delivery_modality
  belongs_to :vehicle_type
end
