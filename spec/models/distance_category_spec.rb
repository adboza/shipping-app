require 'rails_helper'

RSpec.describe DistanceCategory, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when distance_price is empty' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: '', min_distance: 13000, max_distance: 20000, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when deliverty_time is empty' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.2, min_distance: 13000, max_distance: 20000, delivery_time: '')
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when min_distance is empty' do
      
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: '', max_distance: 20000, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end
      
      it 'false when max_distance is empty' do
      
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: 13000, max_distance: '', delivery_time: 36)
        
        result = distance.valid?
       
        expect(result).to eq false
      end

      it 'false when min_distance is less than 100 m' do
       
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: 10, max_distance: 13000, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when have non numeric field min_distance' do
      
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: 'a', max_distance: 20000, delivery_time: 36)
       
        result = distance.valid?
       
        expect(result).to eq false
      end

      it 'false when have non numeric field max_distance' do
       
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: 1000, max_distance: 'a', delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when have non numeric field delivery_time' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: 1000, max_distance: 12000, delivery_time: 'a')
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when have non numeric field distance_price' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 'a', min_distance: 1000, max_distance: 13000, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when have no DeliveryModality' do
                   
        distance = DistanceCategory.new(delivery_modality: nil, distance_price: 0.2, min_distance: 1000, max_distance: 13000, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when min_distance weight is greater than max_distance' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.5, min_distance: 10000, max_distance: 1300, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when distance price is less than zero' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: -1, min_distance: 1000, max_distance: 13000, delivery_time: 36)
        
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when delivery_time is less than zero' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')    
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 1, min_distance: 1000, max_distance: 13000, delivery_time: -36)
       
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when max_distance is not unique' do
      
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
        DistanceCategory.create!(delivery_modality: modality, distance_price: 0.2, min_distance: 1000, max_distance: 13000, delivery_time: 36)   
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.2, min_distance: 7000, max_distance: 13000, delivery_time: 36)
       
        result = distance.valid?
        
        expect(result).to eq false
      end

      it 'false when min_distance is not unique' do
        
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
        DistanceCategory.create!(delivery_modality: modality, distance_price: 0.2, min_distance: 1000, max_distance: 13000, delivery_time: 36)   
        distance = DistanceCategory.new(delivery_modality: modality, distance_price: 0.2, min_distance: 1000, max_distance: 20000, delivery_time: 36)
        
        result = distance.valid?
         
        expect(result).to eq false
      end
    end
  end
end
