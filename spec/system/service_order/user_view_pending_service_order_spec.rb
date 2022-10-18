require 'rails_helper'

describe 'Usuário busca por encomendas pendentes' do
  it 'a partir do menu' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )    
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens pendentes'
   
    expect(current_path).to eq '/service_orders/pending'
  end  
  
  it 'e é usuário regular' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens pendentes'
    click_on 'AB1234567890123'
    
    expect(page).to have_content "Ordem de Serviço AB1234567890123"
    expect(page).to have_content 'Status: Pendente'
  end

  it 'e não existem ordens pendentes' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2, status: :delivered )
    
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Ordens pendentes'
    
    expect(page).to have_content 'Não existem ordens pendentes'
    expect(page).not_to have_content 'AB1234567890123'
  end
end