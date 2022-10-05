require 'rails_helper'

describe 'Usuario vê categorias de peso' do
 it 'a partir da página inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456')
    login_as(user)
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    #Act
    visit root_path
    click_on 'Preços por peso'    

    #Assert    
    expect(current_path).to eq(load_categories_path)
  end
  it 'e visualiza lista' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456')
    login_as(user)
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    #Act
    visit root_path    
    click_on 'Preços por peso'    

    #Assert    
    expect(page).to have_content 'Preços por peso'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'Valor por km'
    expect(page).to have_text '0kg - 10kg'
    #expect(page).to have_content 'R$ 0.5'
    expect(page).to have_content '11kg - 30kg'
    #expect(page).to have_content 'R$ 0.8'
  end
  it 'e não existem pesos cadastrados' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Preços por peso' 

    #Assert
    expect(page).to have_content 'Não existem preços por peso cadastrados'
  end

end