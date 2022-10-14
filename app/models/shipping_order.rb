class ShippingOrder < ApplicationRecord
  belongs_to :delivery_modality
  belongs_to :service_order
  belongs_to :vehicle
  has_one :delivery_modality
  has_one :vehicle
  has_one :load_category, through: :delivery_modality
  has_one :distance_category, through: :delivery_modality
  
end
