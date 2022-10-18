require 'rails_helper'

describe 'Usuario vê seleção de tipo de veículos' do
 it 'a partir da página inicial no modelo relativo' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)   
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'    

    #Assert
    expect(page).to have_content 'Categorias de Veículo por Modalidades'
  end
  it 'e visualiza lista' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    VehicleTypeSelection.create!(vehicle_type: car, delivery_modality: modality)
    VehicleTypeSelection.create!(vehicle_type: utility, delivery_modality: modality)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'  
    expect(page).to have_content 'Categorias de Veículo por Modalidades'
    within('#vehicle_type_selections')do
      expect(page).to have_content 'Tipo de Veículo'
      expect(page).to have_content 'Modalidade'
      expect(page).to have_text 'Expressa'
      expect(page).to have_content 'Carro'
      expect(page).to have_content 'Veículo utilitário'
    end
  end
end