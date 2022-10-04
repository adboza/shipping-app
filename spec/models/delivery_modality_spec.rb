require 'rails_helper'

RSpec.describe DeliveryModality, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when modality name is empty' do
        #Arrange
        modality = DeliveryModality.new(mod_name: '', mod_price: 4)
        #Act
        result = modality.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when modality price is empty' do
        #Arrange
        modality = DeliveryModality.new(mod_name: 'Ecológica', mod_price: '')
        #Act
        result = modality.valid?
        #Assert
        expect(result).to eq false
      end
    end
    it 'false when modality name is already in use' do
      #Arrange
      DeliveryModality.create!(mod_name: 'Expressa', mod_price:2)
      modality = DeliveryModality.new(mod_name: 'Expressa', mod_price:200)
      #Act
      result = modality.valid?
      #Assert
      expect(result).to eq false
    end
  end
end
