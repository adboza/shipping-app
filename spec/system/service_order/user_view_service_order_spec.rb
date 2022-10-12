require 'rails_helper'

describe 'Usuário vê ordens de serviço' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    #Assert
    #expect(page).to have_link 'Ordens de Serviço'
    expect(current_path).to eq service_orders_path
  end
  it 'e há lista de ordens de serviço' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    #Assert
    within('main') do
      expect(page).to have_content 'Ordens de Serviço'
    end
    expect(page).to have_content 'Código de rastreio:'
    expect(page).to have_content 'Endereço de partida: Av. Araucária, 100 Curitiba'
    expect(page).to have_content 'Endereço de entrega: Av. Getúlio Vargas, 300 Curitiba'
    expect(page).to have_content 'Distância da entrega: 10 km'
    expect(page).to have_content 'Peso da mercadoria: 2'
    expect(page).to have_content 'Observações de entrega: Falar com Cris'
  end
  it 'e não há ordens de serviço' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    login_as(user)
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    #Assert
    within('main') do
      expect(page).to have_content 'Ordens de Serviço'
    end
    expect(page).not_to have_content 'Código de rastreio'
    expect(page).to have_content 'Não existem ordens cadastradas'
  end
end