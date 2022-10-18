require 'rails_helper'

describe 'Usuario edita preços por peso dentro de modalidade de entrega' do
  it 'a partir da página inicial no modelo relativo e vê campos' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality:  modality)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on '0kg - 10kg'
    click_on 'Editar cadastro'
    
    expect(page).to have_content 'Peso mínimo'
    expect(page).to have_content 'Peso máximo'
    expect(page).to have_content 'Preço por km'
    expect(page).to have_button 'Salvar'
  end

  it 'e edita peso com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on '0kg - 10kg'
    click_on 'Editar cadastro'
    fill_in 'Peso mínimo', with: 2
    click_on 'Salvar'

    expect(page).to have_content 'Preço por peso atualizado com sucesso'
    expect(page).to have_content '2kg - 10kg'
  end

  it 'e edita peso com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    
    modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_price: 0.5, delivery_modality: modality)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_price: 0.8, delivery_modality: modality)

    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on '0kg - 10kg'
    click_on 'Editar cadastro'
    fill_in 'Peso mínimo', with: 11
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar o preço por peso'  
    expect(page).to have_content 'Peso mínimo'
    expect(page).to have_content 'Peso máximo'
    expect(page).to have_content 'Preço por km'
    expect(page).not_to have_content '0kg - 10kg'
  end
end