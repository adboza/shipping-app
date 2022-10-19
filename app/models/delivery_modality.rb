class DeliveryModality < ApplicationRecord
  validates :mod_name, :mod_price, presence: true
  validates :mod_name, uniqueness: true
  has_many :load_categories
  has_many :distance_categories
  has_many :vehicle_type_selection
  has_many :vehicle_types, through: :vehicle_type_selection
  enum status: {active: 0, deactivated: 9}
end
