class ShippingOrder < ApplicationRecord
  belongs_to :delivery_modality
  belongs_to :service_order
  belongs_to :vehicle
  has_one :delivery_modality
  has_one :vehicle
  has_one :load_category, through: :delivery_modality
  has_one :distance_category, through: :delivery_modality
  
  enum status: {delivered: 0, late: 5, canceled: 9}
  before_validation :set_vehicle, on: :create

  def prices_budget(service_order)
    show_prices = all_avaiable_load_and_distance_categories(service_order)    
  end
  def set_hidden_params(index_value, hashes_array)
    set_this_hidden_params(index_value, hashes_array)    
  end
  

  private

  def set_vehicle
    vehicle_types = VehicleTypeSelection.where(delivery_modality_id: self.delivery_modality_id)    
    vehicle_types.each do |type|
      vehicle = Vehicle.find_by(vehicle_type_id: type.vehicle_type_id, status: :available)
      return self.vehicle_id = vehicle.id
    end
  end

  def set_this_hidden_params(index_value, hashes_array)
    hashes_array.each do |hash|
      if hash[:delivery_modality_id] == index_value
        self.load_category_id = hash[:load_category_id]
        self.distance_category_id = hash[:distance_category_id]
        calculate_estim_delivery_date(hash[:delivery_time])
      end
    end
  end

  def available_delivery_modalities
    delivery_modalities = DeliveryModality.all
    available_modalities = []
    
      delivery_modalities.each do |modality|
        available_modalities << {delivery_modality_id: modality.id, modality_name: modality.mod_name, modality_price: modality.mod_price}
      end
    
    available_modalities
  end

  def all_avaiable_load_categories(service_order)
    available_delivery_modalities = available_delivery_modalities()
    shipping_weight = service_order.goods_weight
    all_load_categories = []
    available_delivery_modalities.each do |modality_hash|  
      if modality_hash.has_key?(:delivery_modality_id)          
        load_categories = LoadCategory.all.where(delivery_modality_id: modality_hash[:delivery_modality_id])
        load_categories.each do |range|
          if (range.min_weight..range.max_weight).include? shipping_weight
            load_category = {}
            load_category.replace(modality_hash)
            load_category[:load_category_id] = range.id
            load_category[:load_km_price] = range.weight_price
            all_load_categories << load_category
          end
        end
      end
    end
    all_load_categories
  end

  def all_avaiable_load_and_distance_categories(service_order)
    load_categories = all_avaiable_load_categories(service_order)
    distance = service_order.shipping_distance
    all_load_and_distance_categories = []
    budget_index = 0
    load_categories.each do |h|
      if h.has_key?(:delivery_modality_id)
        distance_categories = DistanceCategory.all.where(delivery_modality_id: h[:delivery_modality_id])
        distance_categories.each do |range|
          if (range.min_distance..range.max_distance).include? distance
            load_distance_category = {}
            load_distance_category.replace(h)
            load_distance_category[:distance_category_id] = range.id
            load_distance_category[:delivery_time] = range.delivery_time
            load_distance_category[:distance_km_price] = range.distance_price
            this_budget = calculate_budget_value(load_distance_category[:modality_price], distance, load_distance_category[:load_km_price], load_distance_category[:distance_km_price])
            budget_index += 1
            load_distance_category[:budget_index] = budget_index
            load_distance_category[:budget] = this_budget
            all_load_and_distance_categories << load_distance_category
          end
        end
      end
    end
    all_load_and_distance_categories
  end

  def calculate_budget_value(modality_price, distance, load_km_price, distance_km_price)    
    total_budget = (modality_price+((distance/1000)*load_km_price)+((distance/1000)*distance_km_price))
    total_budget
  end

  def calculate_estim_delivery_date(delivery_time)
    self.estim_delivery_date = Time.now+delivery_time
  end
end
