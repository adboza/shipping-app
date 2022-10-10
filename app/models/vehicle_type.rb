class VehicleType < ApplicationRecord

  enum vehicle_type: { undefined: 0, utility_vehicle: 3, bicycle: 5, motorcycle: 7, car: 9 }
end
