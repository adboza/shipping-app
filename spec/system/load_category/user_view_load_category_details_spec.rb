require 'rails_helper'

describe 'Usuario vê detalhes de categoria de peso' do
 it 'a partir da página inicial no modelo relativo' do
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
  #expect(page).to have_content 'bleb'
 end
end