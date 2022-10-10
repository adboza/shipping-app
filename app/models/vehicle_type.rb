class VehicleType < ApplicationRecord
  belongs_to :delivery_modality
  belongs_to :vehicle

  enum status: { undefined: 0, utility_vehicle: 3, bicycle: 5, motorcycle: 7, car: 9 }
end
