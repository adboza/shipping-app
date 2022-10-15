require 'rails_helper'

describe 'Usuario vê detalhes de categoria de peso' do
 it 'a partir da página inicial no modelo relativo e é admin' do
  user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
  modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
  LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
  LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)
  #Act
  login_as(user)
  visit root_path
  click_on 'Modalidades de Entrega'
  click_on 'Expressa'
  click_on '0kg - 10kg'  
  #Assert
  expect(page).to have_content 'Editar cadastro'
  expect(page).to have_content 'Nome modalidade: Expressa'
  expect(page).to have_content 'peso: 0kg - 10kg'
 end

 it 'a partir da página inicial no modelo relativo e é regular' do
  user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)    
  modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
  LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
  LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)
  #Act
  login_as(user)
  visit root_path
  click_on 'Modalidades de Entrega'
  click_on 'Expressa'
  click_on '0kg - 10kg'  
  #Assert
  expect(page).not_to have_content 'Editar cadastro'
  expect(page).to have_content 'Nome modalidade: Expressa'
  expect(page).to have_content 'peso: 0kg - 10kg'
 end
end