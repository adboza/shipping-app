class ShippingOrder < ApplicationRecord
  belongs_to :quotation
  belongs_to :service_order
  belongs_to :vehicle, optional: true

  after_create :set_estimated_delivery_date, :set_vehicle
  after_update :check_vehicle_status, :check_service_order_status


  validate :received_date_greater_than_initial_delivery
  validate :late_received_date_comments
  
  
  private

  def set_estimated_delivery_date()
    delivery_time = self.quotation.distance_category.delivery_time
    self.estimated_delivery_date = Time.now+(delivery_time*3600)
  end

  def set_vehicle()
    vehicles_type = VehicleTypeSelection.where(delivery_modality_id: self.quotation.delivery_modality_id)
    vehicles_type.each do |vehicle_type|
      vehicle = Vehicle.find_by(vehicle_type_id: vehicle_type.vehicle_type_id, status: :available)
      if vehicle.nil? == false && vehicle.load_capacity > self.service_order.goods_weight
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
      if self.received_date > self.estimated_delivery_date
        service_order.update(status: :late_finished)
      else
        service_order.update(status: :finished)
      end
    elsif self.estimated_delivery_date < Date.today
      service_order.update(status: :late)
    else
      service_order.update(status: :delivered)
    end
  end
  
  def received_date_greater_than_initial_delivery
    if self.received_date.present? && self.created_at > self.received_date
      self.errors.add(:received_date, ' deve ser maior que criação da ordem.')
    end
  end
  
  def late_received_date_comments
    if self.received_date.present? && self.received_date > self.estimated_delivery_date && self.late_comments.present? == false
      self.errors.add(:late_comments, "é campo obrigatório para entregas com atraso")
    end
  end
end
