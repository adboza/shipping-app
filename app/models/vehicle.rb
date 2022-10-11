class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  validates :licence_plate, :status, :year, :load_capacity, :vehicle_type_id , :model, presence: true
  validates :load_capacity, numericality: {greater_than_or_equal_to: 0}
  validates :load_capacity, numericality: true
  validates :licence_plate, uniqueness: true, length: { is: 7 }

  enum status: { unavailable: 0, on_delivery: 5, available: 9 }
end
