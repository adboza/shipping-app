class ShippingOrder < ApplicationRecord
  belongs_to :quotation
  belongs_to :service_order
  belongs_to :vehicle, optional: true

  after_create :set_estimated_delivery_date, :set_vehicle
  after_update :check_vehicle_status, :check_service_order_status

  private
  def set_estimated_delivery_date()
    delivery_time = self.quotation.distance_category.delivery_time
    self.estimated_delivery_date = Time.now+(delivery_time*3600)
  end
  def set_vehicle()
    vehicles_type = VehicleTypeSelection.where(delivery_modality_id: self.quotation.delivery_modality_id)
    vehicles_type.each do |vehicle_type|
      vehicle = Vehicle.find_by(vehicle_type_id: vehicle_type.vehicle_type_id, status: :available)
      if vehicle.nil? == false
        vehicle.update(status: :on_delivery)
        return self.vehicle = vehicle
      end
    end
  end
  def check_vehicle_status
    if self.received_date.nil? == false
      vehicle = self.vehicle
      vehicle.update(status: :available)
    end
  end
  def check_service_order_status
    service_order = self.service_order
    if self.received_date.nil? == false      
      service_order.update(status: :finished)
    elsif self.estimated_delivery_date < Date.today
      service_order.update(status: :late)
    else
      service_order.update(status: :delivered)
    end
  end

end
