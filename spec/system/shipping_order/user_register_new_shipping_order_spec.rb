require 'rails_helper'

describe 'Usuário inicializa ordens de entrega' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Rute', shipping_distance: 10000, goods_weight: 2 )
    
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    #Assert
    expect(page).to have_content 'Ordem de Serviço AB1234567890123'
    expect(page).to have_content 'Código de rastreio: AB1234567890123'
    expect(page).to have_content 'Iniciar ordem de entrega'
  end

  it 'e visualiza orçamento antes de inicializar' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Rute', shipping_distance: 10000, goods_weight: 2 )
    expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
    l2_expressa = LoadCategory.create!(min_weight: 6, max_weight: 9, weight_price: 0.9, delivery_modality: expressa)
    d1_expressa = DistanceCategory.create!(min_distance: 100, max_distance: 9900, distance_price: 0.5, delivery_modality: expressa, delivery_time: 12)
    d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
    padrao = DeliveryModality.create!(mod_name: 'Padrão', mod_price: '5')
    l1_padrao = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.2, delivery_modality: padrao)
    d2_padrao = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: padrao, delivery_time: 36)
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Iniciar ordem de entrega'
    #Assert
    expect(page).to have_content 'Nova Ordem de entrega'
    expect(page).to have_content 'Modalidade: Expressa'
    expect(page).to have_content 'Orçamentos disponíveis para ordem de serviço'
    expect(page).to have_content 'Taxa inicial da modalidade: R$ 15,00'
    expect(page).to have_content 'Preço por km para categoria de peso: R$ 0,80'
    expect(page).to have_content 'Preço por km para categoria de distância: R$ 0,60'
    expect(page).to have_content 'Prazo de entrega: 12h'
    expect(page).to have_content 'Total para orçamento: R$ 29,00'
  end

  it 'e visualiza orçamento antes de inicializar' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AB1234567890123')
    ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Rute', shipping_distance: 10000, goods_weight: 2 )
    expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
    l2_expressa = LoadCategory.create!(min_weight: 6, max_weight: 9, weight_price: 0.9, delivery_modality: expressa)
    d1_expressa = DistanceCategory.create!(min_distance: 100, max_distance: 9900, distance_price: 0.5, delivery_modality: expressa, delivery_time: 12)
    d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
    padrao = DeliveryModality.create!(mod_name: 'Padrão', mod_price: '5')
    l1_padrao = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.2, delivery_modality: padrao)
    d2_padrao = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: padrao, delivery_time: 36)
    #Act
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Detalhes - AB1234567890123'
    click_on 'Iniciar ordem de entrega'
    within '#select_array' do
      find(:css, '.form-control').select('1 - Expressa(1) - R$ 29,00')
    end
    click_on 'Salvar'       
    #Assert    
    expect(page).to have_content 'Código de rastreio: AB1234567890123'
    expect(page).to have_content 'Ordem de entrega inicializada com sucesso'
  end
end