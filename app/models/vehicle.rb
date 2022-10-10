class Vehicle < ApplicationRecord
  belongs_to :vehicle_type

  enum status: { unavailable: 0, on_delivery: 5, available: 9 }
end
