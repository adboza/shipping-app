require 'rails_helper'

describe 'Usuário vê modalidades de entrega' do
  it 'a partir do menu' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')
    login_as(user)
    
    visit root_path
    click_on 'Modalidades de Entrega'
    
    expect(page).to have_link 'Modalidades de Entrega'
    expect(current_path).to eq delivery_modalities_path
  end
  it 'e vê lista de modalidades' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')
    padrao = DeliveryModality.create!(mod_name: 'Padrão', mod_price: '5', status: :deactivated)
    DeliveryModality.create!(mod_name: 'Ecológica', mod_price: 4)
    
    login_as(user)
    visit root_path
    click_on 'Modalidades de Entrega'
    
    within('main') do
      expect(page).to have_content 'Modalidades de Entrega'
    end
    expect(page).to have_content 'Nome modalidade: Ecológica'
    expect(page).to have_content 'Taxa inicial: R$ 4'
    expect(page).to have_content 'Status: Ativa'
    expect(page).to have_content 'Status: Desativada'
    expect(page).to have_content 'Nome modalidade: Padrão'
    expect(page).to have_content 'Taxa inicial: R$ 5'
  end
  it 'e não vê modalidades cadastradas' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')
    login_as(user)
    
    visit root_path
    click_on 'Modalidades de Entrega'
    
    within('main') do
      expect(page).to have_content 'Modalidades de Entrega'
    end
    expect(page).not_to have_content 'Nome modalidade: Ecológica'
    expect(page).to have_content 'Não existem modalidades cadastradas'
  end
end