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
    expect(page).to have_content 'Distância da entrega: 10 km'
    expect(page).to have_content 'Peso da mercadoria: 2'
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
  it 'e exibe dados de ordens de entrega' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    carro = VehicleType.create!(vehicle_type: :car)
    expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
    l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
    fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)      
    ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)
    encomenda = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
    orcamento = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda)
    entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
    entrega.update(late_comments: nil)
    entrega.save
    
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    
    within('main') do
      expect(page).to have_content 'Ordens de Serviço'
    end
    expect(page).to have_content 'Veículo: Fusca - ABC1102 - Em rota de entrega'
    expect(page).to have_content 'Data de entrega: '
    expect(page).to have_content 'Distância da entrega: 10 km'
    expect(page).to have_content 'Peso da mercadoria: 2'
  end
end