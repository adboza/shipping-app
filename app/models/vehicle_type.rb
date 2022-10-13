class VehicleType < ApplicationRecord
  has_many :vehicles
  has_many :delivery_modalities, through: :vehicle_type_selection

  enum vehicle_type: { undefined: 0, utility_vehicle: 3, bicycle: 5, motorcycle: 7, car: 9 }
end
