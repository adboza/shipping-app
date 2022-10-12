class ServiceOrder < ApplicationRecord
  before_validation :generate_tracking_code, on: :create

  validates :tracking_code, :departure_address, :delivery_address, :shipping_distance, :goods_weight, presence: true
  validates :shipping_distance, numericality: {greater_than_or_equal_to: 100}
  validates :shipping_distance, :goods_weight, numericality: true
  validates :goods_weight, numericality: {greater_than_or_equal_to: 0}
  validates :tracking_code, uniqueness: true
  #rder = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: '' )

  private

  def generate_tracking_code
    self.tracking_code = SecureRandom.alphanumeric(15).upcase
  end
end
