require 'rails_helper'

RSpec.describe Quotation, type: :model do
  describe '#available?' do
    it 'false se ServiceOrder não tiver cotação' do
      #Arrange
      carro = VehicleType.create!(vehicle_type: :car)
      expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
      d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
      l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
      fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
      ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)

      #Act
      encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )

      #Assert
      expect(encomenda.quotations_available?).to eq false
    end
    it 'true se ServiceOrder não tiver cotações' do
      #Arrange
      #Act
      encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2)
      #Assert
      expect(Quotation.find_by(service_order: encomenda)).to eq nil
    end
  end
end
