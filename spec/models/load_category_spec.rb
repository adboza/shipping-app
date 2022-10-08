require 'rails_helper'

RSpec.describe LoadCategory, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when min_weight is empty' do
        #Arrange
        load = LoadCategory.new(min_weight: '', max_weight: 4, weight_price: 1)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when max_weight is empty' do
        #Arrange
        load = LoadCategory.new(min_weight: 2, max_weight: '', weight_price: 1)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when min weight is bigger than max weight' do
        #Arrange
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 7, max_weight: 4, weight_price: 1, delivery_modality_id: modality)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when have non numeric field' do
        #Arrange
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 's', max_weight: 4, weight_price: 1, delivery_modality_id: modality)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when load weight is less than zero' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: -2, max_weight: 4, weight_price: 1, delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when load weight is less than zero' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 2, max_weight: -4, weight_price: 1, delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when load price is less than zero' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 2, max_weight: 4, weight_price: -1, delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when max load price is less than min' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 2, max_weight: 1, weight_price: 1, delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when max load price is less than min' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 2, max_weight: 1, weight_price: 1, delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when min load price is greater than max' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        load = LoadCategory.new(min_weight: 2, max_weight: 1, weight_price: 1, delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when load weight is not unique' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        LoadCategory.create!(min_weight: 2, max_weight: 4, weight_price: 1, delivery_modality_id: modality.id)
        load = LoadCategory.new(min_weight: 2, max_weight: 6, weight_price: 1.2,delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when load weight is not unique' do
        #Arrange
        modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: 4)
        LoadCategory.create!(min_weight: 1, max_weight: 4, weight_price: 1, delivery_modality_id: modality.id)
        load = LoadCategory.new(min_weight: 2, max_weight: 4, weight_price: 1.2,delivery_modality_id: modality.id)
        #Act
        result = load.valid?
        #Assert
        expect(result).to eq false
      end
    end
  end
end
