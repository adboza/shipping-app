require 'rails_helper'

describe 'Usuario vê detalhes de categoria de distância' do
 it 'a partir da página inicial no modelo relativo e é admin' do
  user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    
  modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
  DistanceCategory.create!(min_distance: 100, max_distance: 9900, distance_price: 0.5, delivery_modality: modality, delivery_time: 36)
  DistanceCategory.create!(min_distance: 10000, max_distance: 30000, distance_price: 0.8, delivery_modality: modality, delivery_time: 36)

  #Act
  login_as(user)
  visit root_path
  click_on 'Modalidades de Entrega'
  click_on 'Expressa'
  within('#distance_categories') do
    click_on '10km - 30km'
  end

  #Assert
  expect(page).to have_content 'Distância abrangida:'
  expect(page).to have_content 'Nome modalidade: Expressa'
  expect(page).to have_content 'Distância abrangida: 10km - 30km'
  expect(page).to have_content 'Prazo de entrega: 36h'
  expect(page).to have_content 'Preço por km: R$ 0,80'
  expect(page).to have_content 'Editar cadastro'
  expect(page).not_to have_content 'Distância abrangida: 0km - 9km'
  expect(page).not_to have_content 'Preço por km: R$ 0,50'
 end

 it 'a partir da página inicial no modelo relativo e é regular' do
  user = User.create!(name:'Edna', email:'edna@email.com', password:'123456', user_access: :regular_user)
    
  modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
  DistanceCategory.create!(min_distance: 100, max_distance: 9900, distance_price: 0.5, delivery_modality: modality, delivery_time: 34)
  DistanceCategory.create!(min_distance: 10000, max_distance: 30000, distance_price: 0.8, delivery_modality: modality, delivery_time: 36)

  #Act
  login_as(user)
  visit root_path
  click_on 'Modalidades de Entrega'
  click_on 'Expressa'
  within('#distance_categories') do
    click_on '10km - 30km'
  end

  #Assert
  expect(page).to have_content 'Distância abrangida:'
  expect(page).to have_content 'Nome modalidade: Expressa'
  expect(page).to have_content 'Distância abrangida: 10km - 30km'
  expect(page).to have_content 'Preço por km: R$ 0,80'
  expect(page).to have_content 'Prazo de entrega: 36h'
  expect(page).not_to have_content 'Editar cadastro'
  expect(page).not_to have_content 'Distância abrangida: 0km - 9km'
  expect(page).not_to have_content 'Preço por km: R$ 0,50'
 end
end