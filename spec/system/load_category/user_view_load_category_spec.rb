require 'rails_helper'

describe 'Usuario vê categorias de peso' do
 it 'a partir da página inicial no modelo relativo' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456')
    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'    

    #Assert
    expect(page).to have_content 'Nome modalidade: Expressa'
    expect(page).to have_content 'Preços por peso'
  end
  it 'e visualiza lista' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456')
    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'  

    #Assert    
    expect(page).to have_content 'Preços por peso'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'Valor por km'
    expect(page).to have_text '0kg - 10kg'
    expect(page).to have_content 'R$ 0,5'
    expect(page).to have_content '11kg - 30kg'
    expect(page).to have_content 'R$ 0,8'
  end

end