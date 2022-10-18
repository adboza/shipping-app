require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it 'a partir da tela inicial' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    login_as(user)
    
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    
    expect(page).to have_content 'Status:'
    expect(page).to have_content 'Placa:'
    expect(page).to have_content 'Ano:'
    expect(page).to have_content 'Capacidade máxima de carga:'
    expect(page).to have_content 'Novo Veículo'
    expect(page).to have_content 'Tipo de veículo'
  end
  it 'com sucesso' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    login_as(user)
    
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'    
    fill_in 'Placa', with: 'ABC2500'
    fill_in 'Modelo', with: 'Fusca'
    select 'Em rota de entrega', from: 'Status'
    fill_in 'Ano', with: 2.days.ago
    fill_in 'Capacidade máxima de carga', with: 300
    select 'car', from: 'Tipo de veículo'
    click_on 'Salvar'
    
    expect(page).to have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'Tipo de veículo: Carro'
    expect(page).to have_content 'Placa: ABC2500'
    expect(page).to have_content 'Status: Em rota de entrega'
    expect(page).to have_content 'Capacidade máxima de carga: 300'
    expect(page).to have_content 'Ano: 2022'
  end
end