require 'rails_helper'

describe 'Usuário cadastra uma ordem de serviço' do
  it 'a partir da tela inicial' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar Ordem de Serviço'
    
    expect(page).to have_content 'Endereço de partida'
    expect(page).to have_content 'Endereço de entrega'
    expect(page).to have_content 'Distância da entrega'
    expect(page).to have_content 'Peso da mercadoria'
    expect(page).to have_content 'Observações de entrega'
  end

  it 'com sucesso' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar Ordem de Serviço'
    fill_in 'Endereço de partida', with: 'Av. Araucária, 100 Curitiba - PR'
    fill_in 'Endereço de entrega', with: 'Av. Getúlio Vargas, 300 Curitiba - PR'
    fill_in 'Distância da entrega', with: 4000
    fill_in 'Peso da mercadoria', with: 2
    fill_in 'Observações de entrega', with: 'Falar com Cris'    
    click_on 'Salvar'
    
    expect(page).to have_content 'Ordem de serviço cadastrada com sucesso'
    expect(page).to have_content 'Distância da entrega: 4 km'
  end

  it 'e não é usuário administrador' do
    
    user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user) 
    
    visit root_path
    click_on 'Ordens de Serviço'
     
    expect(page).not_to have_content 'Cadastrar Ordem de Serviço'    
  end
end