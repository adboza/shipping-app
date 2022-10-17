class ServiceOrder < ApplicationRecord
  before_validation :generate_tracking_code, on: :create

  validates :tracking_code, :departure_address, :delivery_address, :shipping_distance, :goods_weight, presence: true
  validates :shipping_distance, numericality: {greater_than_or_equal_to: 100}
  validates :shipping_distance, :goods_weight, numericality: true
  validates :goods_weight, numericality: {greater_than_or_equal_to: 0}
  validates :tracking_code, uniqueness: true
  
  #has_one :shipping_order

  enum status: {pending: 0, delivered: 5, late: 7, canceled: 9}
  
  def available?
    shipping_order.nil? 
  end

  private

  def generate_tracking_code
    self.tracking_code = SecureRandom.alphanumeric(15).upcase
  end
end
