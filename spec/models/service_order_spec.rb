require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when goods_weight is empty' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: '' )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when departure_address is empty' do
        
        order = ServiceOrder.new(departure_address: '', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when delivery_address is empty' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: '', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2)
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when shipping_distance is empty' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: '', goods_weight: 2 )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when shipping_distance is less than 100 m' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10, goods_weight: 2 )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when have non numeric field goods_weight' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 1000, goods_weight: 'a' )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when have non numeric field goods_weight' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 'a', goods_weight: 2 )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when goods weight is less than zero' do
        
        order = ServiceOrder.new(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 1000, goods_weight: -2 )
        
        result = order.valid?
        
        expect(result).to eq false
      end

      it 'false when tracking code is not unique' do
        
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
        ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 ) 
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
        order = ServiceOrder.new(departure_address: 'Rua Pérola, 100 Curitiba - PR', delivery_address: 'Rua Francisco Derosso, 300 Curitiba - PR', comments: 'Falar com Rute', shipping_distance: 800, goods_weight: 12 )
        
        result = order.valid?
        
        expect(result).to eq false
      end
    end
  end
end
