require 'rails_helper'

describe 'Usuario vê detalhes de veículo' do
 it 'a partir da página inicial e é admin' do
  user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
  car = VehicleType.create!(vehicle_type: :car)
  utility = VehicleType.create!(vehicle_type: :utility_vehicle)
  Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, load_capacity: 300)
  Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, load_capacity: 3600)

  #Act
  login_as(user)
  visit root_path
  click_on 'Veículos'
  click_on 'Detalhes - ABC1100'

  #Assert
    expect(page).to have_content 'Placa: ABC1100'
    expect(page).to have_content 'Ano: 2022'
    expect(page).to have_content 'Status: Indisponível'
    expect(page).to have_content 'Capacidade máxima de carga: 300kg'
    expect(page).to have_content 'Tipo de veículo: Carro'
 end

 it 'a partir da página inicial no modelo relativo e é regular' do
  user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)   
  car = VehicleType.create!(vehicle_type: :car)
  utility = VehicleType.create!(vehicle_type: :utility_vehicle)
  Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, load_capacity: 300)
  Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, load_capacity: 3600)

  #Act
  login_as(user)
  visit root_path
  click_on 'Veículos'
  click_on 'Detalhes - CDE1000'

  #Assert
  expect(page).to have_content 'Placa: CDE1000'
  expect(page).to have_content 'Ano: 2021'
  expect(page).to have_content 'Status: Disponível'
  expect(page).to have_content 'Capacidade máxima de carga: 3600kg'
  expect(page).to have_content 'Tipo de veículo: Veículo utilitário'
  expect(page).not_to have_content 'Editar cadastro'
 end
end