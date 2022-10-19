require 'rails_helper'

describe 'Usuário edita uma Modalidade de Entrega' do
  it 'a partir da página de detalhes da modalidade' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
 
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Editar'
    
    expect(page).to have_content 'Editar Modalidade'    
  end

  it 'com sucesso' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
 
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Editar'
    fill_in 'Nome modalidade', with:'Rápida'
    click_on 'Salvar'
    expect(page).to have_content 'Modalidade atualizada com sucesso'
    expect(page).to have_content 'Nome modalidade: Rápida'
    expect(page).not_to have_content 'Expressa'    
  end

  it 'e não é usuário administrador' do
    
    user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
 
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
     
    expect(page).not_to have_content 'Editar'    
  end
end