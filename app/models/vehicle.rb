class Vehicle < ApplicationRecord
  has_many :delivery_modalities, through: :vehicle_types

  enum status: { unavailable: 0, on_delivery: 5, available: 9 }
end
