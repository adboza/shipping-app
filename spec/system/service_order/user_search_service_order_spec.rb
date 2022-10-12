require 'rails_helper'

describe 'Usuário busca por uma encomenda' do
  it 'a partir do menu' do
    #Arrange

    #Act
    visit root_path
    #Assert
    within('header nav') do
      expect(page).to have_field('Buscar Encomenda:')
      expect(page).to have_button('Buscar')
    end
  end
  
  it 'e encontra uma encomenda' do
    #Arrange
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )   
    #Act
    visit root_path
    fill_in 'Buscar Encomenda:', with: 'AB1234567890123'
    click_on 'Buscar'
    #Assert
    expect(page).to have_content "Resultados da Busca por: AB1234567890123"
    expect(page).to have_content '1 ordem de serviço encontrada'
    expect(page).to have_content "Código de rastreio: AB1234567890123"
    expect(page).to have_content 'Endereço de partida: Av. Araucária, 100 Curitiba - PR'
    expect(page).to have_content 'Endereço de entrega: Av. Getúlio Vargas, 300 Curitiba - PR'
    expect(page).to have_content 'Distância da entrega: 10 km'
    expect(page).to have_content 'Peso da mercadoria: 2 kg'
    expect(page).to have_content 'Observações de entrega: Falar com Cris'

  end

  it 'e encontra múltiplas encomendas' do
    #Arrange
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 ) 
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('BB1234567890123')
    ServiceOrder.create!(departure_address: 'Rua Pérola, 100 Curitiba - PR', delivery_address: 'Rua Francisco Derosso, 300 Curitiba - PR', comments: 'Falar com Rute', shipping_distance: 800, goods_weight: 12 )
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('BB7734567890123')
    ServiceOrder.create!(departure_address: 'Rua Cascavel, 100 Curitiba - PR', delivery_address: 'Rua Marechal Floriano Peixoto, 12300 Curitiba - PR', comments: 'Falar com Diomira', shipping_distance: 2800, goods_weight: 3 )   
    #Act
      visit root_path
      fill_in 'Buscar Encomenda', with: "1234567890123"
      click_on 'Buscar'
      #Assert
      expect(page).to have_content "2 ordens de serviço encontradas"
      expect(page).to have_content 'AB1234567890123'
      expect(page).to have_content 'BB1234567890123'
      expect(page).to have_content 'Endereço de entrega: Av. Getúlio Vargas, 300 Curitiba - PR'
      expect(page).not_to have_content 'BB7734567890123'
      expect(page).not_to have_content 'Rua Marechal Floriano Peixoto, 12300 Curitiba - PR'
  end
end