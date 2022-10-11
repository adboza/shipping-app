require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    login_as(user)
    #Act
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    #Assert
    expect(page).to have_content 'Status:'
    expect(page).to have_content 'Placa:'
    expect(page).to have_content 'Ano:'
    expect(page).to have_content 'Capacidade máxima de carga:'
    expect(page).to have_content 'Novo Veículo'
    expect(page).to have_content 'Tipo de veículo'
  end
  it 'com sucesso' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    login_as(user)
    #Act
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    
    fill_in 'Placa', with: 'ABC2500'
    select 'Em rota de entrega', from: 'Status'
    fill_in 'Ano', with: 2.days.ago
    fill_in 'Capacidade máxima de carga', with: 300
    select 'car', from: 'Tipo de veículo'
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'Tipo de veículo: Carro'
    expect(page).to have_content 'Placa: ABC2500'
    expect(page).to have_content 'Status: Em rota de entrega'
    expect(page).to have_content 'Capacidade máxima de carga: 300'
    expect(page).to have_content 'Ano: 2022'
  end

  # it 'com falha' do
  #   #Arrange
  #   user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
  #   car = VehicleType.create!(vehicle_type: :car)
  #   utility = VehicleType.create!(vehicle_type: :utility_vehicle)
  #   login_as(user)
  #   Vehicle.create!(licence_plate: ABC1100, status: :unavailable, year: 2022, vehicle_type: car, load_capacity: 300)
  #   #Act
  #   visit root_path
  #   click_on 'Modalidades de Entrega'
  #   click_on 'Cadastrar Modalidade'
    
  #   fill_in('Nome modalidade', with: 'Ecológica')
  #   fill_in 'Taxa inicial', with: ''
    
  #   click_on 'Salvar'
  #   #Assert
  #   expect(page).to have_content 'Não foi possível cadastrar a modalidade'
  #   expect(page).to have_content 'Verifique os erros abaixo:'
  #   expect(page).to have_content 'Nome modalidade já está em uso'
  #   expect(page).to have_content 'Taxa inicial não pode ficar em branco'
  #   expect(current_path).to eq delivery_modalities_path
  # end

  # it 'e não é usuário administrador' do
  #   #Arrange
  #   user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
  #   login_as(user)
  #   car = VehicleType.create!(vehicle_type: :car)
  #   utility = VehicleType.create!(vehicle_type: :utility_vehicle)
  #   Vehicle.create!(licence_plate: ABC1100, status: :unavailable, year: 2022, vehicle_type: car, load_capacity: 300)
  #   Vehicle.create!(licence_plate: CDE1000, status: :available, year: 2021, vehicle_type: utility, load_capacity: 3600)
 
  #   #Act
  #   visit root_path
  #   click_on 'Modalidades de Entrega'
  #   #Assert    
  #   expect(page).not_to have_content 'Cadastrar Modalidade'    
  # end
end