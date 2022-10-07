require 'rails_helper'

describe 'Usuario vê categorias de distância' do
 it 'a partir da página inicial no modelo relativo' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :regular_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)
    DistanceCategory.create!(delivery_modality: modality, distance_price: 0.2, min_distance: 100, max_distance: 12000)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'    

    #Assert
    expect(page).to have_content 'Nome modalidade: Expressa'
    expect(page).to have_content 'Preços por distância'
    expect(page).not_to have_content '12000'
    expect(page).not_to have_content 'Preços por distância não cadastrados'
  end
  it 'e não existem categorias por distância para o modelo' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :regular_user)    
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
    expect(page).to have_content 'Preços por distância'
    expect(page).not_to have_content '12000'
    expect(page).to have_content 'Não existem preços por distância cadastrados'
    within('#distance_categories') do
      expect(page).not_to have_content 'Intervalo'
    end
  end
end