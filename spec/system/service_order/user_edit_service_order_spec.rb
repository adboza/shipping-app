require 'rails_helper'

describe 'Usuário edita uma Ordem de Serviço' do
  it 'a partir da página de detalhes da Ordem de serviço' do
   
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
 
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Editar'
    
    expect(page).to have_content 'Editar Ordem de Serviço'    
  end

  it 'com sucesso' do
    
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
 
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Editar'
    fill_in 'Observações de entrega', with: 'Falar com Edilene'
    click_on 'Salvar'
    
    expect(page).to have_content 'Ordem de serviço atualizada com sucesso'
    expect(page).to have_content 'Observações de entrega: Falar com Edilene'
    expect(page).not_to have_content 'Observações de entrega: Falar com Cris'    
  end

  it 'e não é usuário administrador' do
   
    user = User.create!(name:'Edna', email:'edna@email.com', password:'123456', user_access: :regular_user)
    login_as(user)    
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
 
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    
    within '#admin_edit' do
      expect(page).not_to have_content 'Editar'
    end
  end
end