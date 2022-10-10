class Vehicle < ApplicationRecord

  enum status: { unavailable: 0, on_delivery: 5, available: 9 }
end
