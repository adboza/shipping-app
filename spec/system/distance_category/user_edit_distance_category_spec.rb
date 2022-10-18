require 'rails_helper'

describe 'Usuario edita preços por distância dentro de modalidade de entrega' do
 it 'a partir da página inicial no modelo relativo e vê campos' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    DistanceCategory.create!(min_distance: 100, max_distance: 10000, distance_price: 0.5, delivery_modality: modality, delivery_time: 36)
    DistanceCategory.create!(min_distance: 11000, max_distance: 30000, distance_price: 0.8, delivery_modality: modality, delivery_time: 36)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on '0km - 10km'
    click_on 'Editar cadastro'
  
    expect(page).to have_content 'Distância mínima'
    expect(page).to have_content 'Distância máxima'
    expect(page).to have_content 'Prazo de entrega'
    expect(page).to have_content 'Preço por km'
    expect(page).to have_button 'Salvar'
  end

  it 'e edita distância com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    modality = DeliveryModality.create!(mod_name: 'Rápida', mod_price: '15')
    DistanceCategory.create!(min_distance: 100, max_distance: 10000, distance_price: 0.5, delivery_modality: modality, delivery_time: 36)
    DistanceCategory.create!(min_distance: 11000, max_distance: 30000, distance_price: 0.8, delivery_modality: modality, delivery_time: 36)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Rápida'
    click_on '0km - 10km'  
    click_on 'Editar cadastro'
    fill_in 'Distância máxima', with: 8000
    click_on 'Salvar'

    expect(page).to have_content 'Preço por distância atualizado com sucesso'
    within('#distance_categories')do
      expect(page).to have_content '0km - 8km'
    end
  end

  it 'e edita preço com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    modality = DeliveryModality.create!(mod_name: 'Rápida', mod_price: '15')
    DistanceCategory.create!(min_distance: 100, max_distance: 10000, distance_price: 0.5, delivery_modality: modality, delivery_time: 36)
    DistanceCategory.create!(min_distance: 11000, max_distance: 30000, distance_price: 0.8, delivery_modality: modality, delivery_time: 36)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Rápida'
    click_on '0km - 10km'  
    click_on 'Editar cadastro'
    fill_in 'Preço por km', with: 0.75
    click_on 'Salvar'

    expect(page).to have_content 'Preço por distância atualizado com sucesso'
    within('#distance_categories')do
      expect(page).to have_content 'R$ 0,75'
    end
  end

  it 'e edita prazo com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    modality = DeliveryModality.create!(mod_name: 'Rápida', mod_price: '15')
    DistanceCategory.create!(min_distance: 100, max_distance: 10000, distance_price: 0.5, delivery_modality: modality, delivery_time: 36)
    DistanceCategory.create!(min_distance: 11000, max_distance: 30000, distance_price: 0.8, delivery_modality: modality, delivery_time: 36)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Rápida'
    click_on '0km - 10km'  
    click_on 'Editar cadastro'
    fill_in 'Prazo de entrega', with: 34
    click_on 'Salvar'

    expect(page).to have_content 'Preço por distância atualizado com sucesso'
    within('#distance_categories')do
      expect(page).to have_content '34h'
    end
  end
end