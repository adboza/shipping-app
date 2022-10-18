require 'rails_helper'

describe 'Usuário vê detalhes da ordem de serviço' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )    
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    #Assert
    expect(page).to have_content 'Ordem de Serviço AB1234567890123'
    expect(page).to have_content 'Código de rastreio: AB1234567890123'
    expect(page).to have_content 'Endereço de partida: Av. Araucária, 100 Curitiba - PR'
    expect(page).to have_content 'Endereço de entrega: Av. Getúlio Vargas, 300 Curitiba - PR'
    expect(page).to have_content 'Distância da entrega: 10 km'
    expect(page).to have_content 'Peso da mercadoria: 2 kg'
    expect(page).to have_content 'Observações de entrega: Falar com Cris'        
  end
  
end