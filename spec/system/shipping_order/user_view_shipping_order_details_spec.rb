require 'rails_helper'

describe 'Usuário vê detalhes da ordem de entrega' do
  it 'a partir da tela inicial pela ordem de serviço' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    carro = VehicleType.create!(vehicle_type: :car)
    expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
    l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
    fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
    ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
    orcamento = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda)
    entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
    
    #Act
    login_as(user)
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
    expect(page).to have_content 'Modalidade: Expressa'
    expect(page).to have_content 'Orçamento: R$ 29,00'
    expect(page).not_to have_content 'Ordem de entrega não inicializada'     
  end
  
end