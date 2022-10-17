class ServiceOrder < ApplicationRecord
  before_validation :generate_tracking_code, on: :create

  validates :tracking_code, :departure_address, :delivery_address, :shipping_distance, :goods_weight, presence: true
  validates :shipping_distance, numericality: {greater_than_or_equal_to: 100}
  validates :shipping_distance, :goods_weight, numericality: true
  validates :goods_weight, numericality: {greater_than_or_equal_to: 0}
  validates :tracking_code, uniqueness: true
  has_one :shipping_order

  has_many :quotations
  
  #has_one :shipping_order

  enum status: {pending: 0, delivered: 3, late: 5, finished: 7, canceled: 9}

  after_create :create_quotations

  def prices_quotation
    show_prices = all_avaiable_load_and_distance_categories
  end

  def quotations_available?
    quotations.nil?      
  end

  def calculate_quotation_value(modality_price, distance, load_km_price, distance_km_price)   
    total_quotation = (modality_price+((distance/1000)*load_km_price)+((distance/1000)*distance_km_price))
    total_quotation
  end

  private

  def generate_tracking_code
    self.tracking_code = SecureRandom.alphanumeric(15).upcase
  end

  def create_quotations
    available_quotation_list = all_avaiable_load_and_distance_categories()
    available_quotation_list.each do |h|      
      delivery_modality = DeliveryModality.find_by(id: h[:delivery_modality_id])
      load_category = LoadCategory.find_by(id: h[:load_category_id])
      distance_category = DistanceCategory.find_by(id: h[:distance_category_id])
      Quotation.create!(delivery_modality: delivery_modality, load_category: load_category, distance_category: distance_category, service_order: self)
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

  def all_avaiable_load_categories()
    available_delivery_modalities = available_delivery_modalities()
    shipping_weight = self.goods_weight
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

  def all_avaiable_load_and_distance_categories()
    load_categories = all_avaiable_load_categories()
    distance = self.shipping_distance
    all_load_and_distance_categories = []
    quotation_index = 0
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
            this_quotation = calculate_quotation_value(load_distance_category[:modality_price], distance, load_distance_category[:load_km_price], load_distance_category[:distance_km_price])
            quotation_index += 1
            load_distance_category[:quotation_index] = quotation_index
            load_distance_category[:quotation] = this_quotation
            all_load_and_distance_categories << load_distance_category
          end
        end
      end
    end
    all_load_and_distance_categories
  end
  
  


end
