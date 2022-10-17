class ShippingOrder < ApplicationRecord
  belongs_to :quotation
  belongs_to :service_order
  belongs_to :vehicle, optional: true
end
