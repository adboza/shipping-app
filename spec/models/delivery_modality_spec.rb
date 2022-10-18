require 'rails_helper'

RSpec.describe DeliveryModality, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when modality name is empty' do
       
        modality = DeliveryModality.new(mod_name: '', mod_price: 4)
        
        result = modality.valid?
        
        expect(result).to eq false
      end

      it 'false when modality price is empty' do
       
        modality = DeliveryModality.new(mod_name: 'Ecológica', mod_price: '')
        
        result = modality.valid?
       
        expect(result).to eq false
      end
    end
    
    it 'false when modality name is already in use' do
      
      DeliveryModality.create!(mod_name: 'Expressa', mod_price:2)
      modality = DeliveryModality.new(mod_name: 'Expressa', mod_price:200)
      
      result = modality.valid?
      
      expect(result).to eq false
    end
  end
end
