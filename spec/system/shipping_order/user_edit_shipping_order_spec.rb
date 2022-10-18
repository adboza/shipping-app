require 'rails_helper'

describe 'Usuário edita detalhes da ordem de entrega' do
  it 'a partir da tela inicial pela ordem de serviço' do
    
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
    entrega.update(late_comments: nil)
    
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    
    expect(page).to have_content 'Editar ordem de entrega' 
  end

  it 'e vê campos para preenchimento' do
    
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
    entrega.update(late_comments: nil)    
   
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Editar ordem de entrega'
    
    expect(page).to have_content 'Editar Ordem de Entrega - AB1234567890123'
    expect(page).to have_content 'Data de recebimento'
    expect(page).to have_content 'Justificativa de atraso'   
  end

  it 'com sucesso' do
   
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
    allow(Time).to receive(:now).and_return(Time.now-1.day)
    entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
    entrega.update(late_comments: nil)    
    
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Editar ordem de entrega'
    fill_in 'Data de recebimento', with: Date.today
    click_on 'Salvar'
    
    expect(page).to have_content 'Ordem de entrega atualizada com sucesso'
    expect(page).to have_content 'Data de recebimento:'
    expect(page).to have_content 'Status: Entregue'
  end

  it 'e registra entrega com atraso' do
   
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
    allow(Time).to receive(:now).and_return(Time.now-3.days)
    entrega = ShippingOrder.create!(service_order: encomenda, quotation: orcamento)
    entrega.update(late_comments: nil)    
    
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Editar ordem de entrega'
    fill_in 'Data de recebimento', with: Date.today
    fill_in 'Justificativa de atraso', with: 'Foram necessárias 3 tentativas de entrega.'
    click_on 'Salvar'
    
    expect(page).to have_content 'Ordem de entrega atualizada com sucesso'
    expect(page).to have_content 'Data de recebimento:'
    expect(page).to have_content 'Status: Entregue'
    expect(page).to have_content 'Entregue com atraso'
    expect(page).to have_content 'Foram necessárias 3 tentativas de entrega.'
  end
  
end