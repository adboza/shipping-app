require 'rails_helper'

RSpec.describe ShippingOrder, type: :model do
  describe '#after_create attributes present?' do
    it 'false se ShippingOrder não tiver estimated_delivery_date' do
      
      carro = VehicleType.create!(vehicle_type: :car)
      expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
      d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
      l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
      fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
      ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)
      
      encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
      orcamento = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda)
      entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
  
      expect(entrega.estimated_delivery_date).not_to eq nil
    end
    it 'false se ShippingOrder não tiver vehicle' do
      
      carro = VehicleType.create!(vehicle_type: :car)
      expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
      d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
      l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
      fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
      ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)      
      encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
      orcamento = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda)
      entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
  
      expect(entrega.vehicle).not_to eq nil
    end

    it 'false se ShippingOrder tiver received_date maior que criação da entrega' do
      
      carro = VehicleType.create!(vehicle_type: :car)
      expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
      d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
      l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
      fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
      ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)      
      encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
      orcamento = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda)
      allow(Time).to receive(:now).and_return(Time.now-3.days)
      entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)        
      entrega.update(received_date: Date.today, late_comments: '')

      result = entrega.valid?
  
      expect(result).to eq false
    end

    it 'false se late_comments em branco p/ received_date maior que estimated_delivery_date' do
      
      carro = VehicleType.create!(vehicle_type: :car)
      expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
      d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
      l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
      fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
      ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)
      
      encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
      orcamento = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda)
      entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
        
      entrega.update(received_date: Time.now-1.days)
      result = entrega.valid?
  
      expect(result).to eq false
    end
  end
end
