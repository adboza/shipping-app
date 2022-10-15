class ShippingOrder < ApplicationRecord
  belongs_to :delivery_modality
  belongs_to :service_order
  belongs_to :vehicle
  has_one :delivery_modality
  has_one :vehicle
  has_one :load_category, through: :delivery_modality
  has_one :distance_category, through: :delivery_modality
  
  before_validation :prices_budget, on: :new
  # before_validation :set_vehicle, calculate_estim_delivery_date on: :create
  # create_table "shipping_orders", force: :cascade do |t|
  #   t.integer "delivery_modality_id", null: false
  #   t.integer "service_order_id", null: false
  #   t.integer "vehicle_id", null: false
  #   t.integer "status"
  #   t.datetime "received_date"
  #   t.datetime "estim_delivery_date"
  #   t.string "late_comments"
  #   t.integer "load_category_id", null: false
  #   t.integer "distance_category_id", null: false

  def prices_budget(service_order)
    show_prices = all_avaiable_load_and_distance_categories(service_order)    
  end
  

  private
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
end
