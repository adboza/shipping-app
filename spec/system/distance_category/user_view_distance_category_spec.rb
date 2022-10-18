require 'rails_helper'

describe 'Usuario vê categorias de distância' do
  it 'a partir da página inicial no modelo relativo' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)
    DistanceCategory.create!(delivery_modality: modality, distance_price: 0.2, min_distance: 100, max_distance: 12000, delivery_time: 36)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'    

    expect(page).to have_content 'Nome modalidade: Expressa'
    expect(page).to have_content 'Preços por distância'
    expect(page).not_to have_content '12000'
    expect(page).not_to have_content 'Preços por distância não cadastrados'
  end
  it 'e não existem categorias por distância para o modelo' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'    

    expect(page).to have_content 'Nome modalidade: Expressa'
    expect(page).to have_content 'Preços por distância'
    expect(page).not_to have_content '12000'
    expect(page).to have_content 'Não existem preços por distância cadastrados'
    within('#distance_categories') do
      expect(page).not_to have_content 'Intervalo'
    end
  end
  it 'e visualiza lista' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)
    DistanceCategory.create!(delivery_modality: modality, distance_price: 0.2, min_distance: 100, max_distance: 12000, delivery_time: 34)
    DistanceCategory.create!(delivery_modality: modality, distance_price: 0.5, min_distance: 13000, max_distance: 20000, delivery_time: 36)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'    

    expect(page).to have_content 'Nome modalidade: Expressa'
    expect(page).to have_content 'Preços por distância'
    expect(page).not_to have_content '12000'
    expect(page).not_to have_content 'Preços por distância não cadastrados'
    within('#distance_categories') do
      expect(page).to have_content '0km - 12km'
      expect(page).to have_content '13km - 20km'
      expect(page).to have_content 'R$ 0,20'
      expect(page).to have_content 'R$ 0,50'
      expect(page).to have_content 'Expressa'
      expect(page).to have_content '34h'
      expect(page).to have_content '36h'
    end
  end
end