require 'rails_helper'

describe 'Usuario edita veículos' do
 it 'a partir da página inicial e vê campos' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, model: 'Fusca', load_capacity: 300)
    Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, model: 'Fusca', load_capacity: 3600)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Detalhes - ABC1100'
    click_on 'Editar cadastro'
  
    #Assert
    expect(page).to have_content 'Editar Veículo'
    expect(page).to have_content 'Placa:'
    expect(page).to have_content 'Ano:'
    expect(page).to have_content 'Status:'
    expect(page).to have_content 'Capacidade máxima de carga:'
    expect(page).to have_content 'Tipo de veículo:'
    expect(page).to have_button 'Salvar'
  end

  it 'e edita status com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, model: 'Fusca', load_capacity: 300)
    Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, model: 'Fusca', load_capacity: 3600)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Detalhes - ABC1100'
    click_on 'Editar cadastro'
    select 'Em rota de entrega', from: 'Status'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Veículo atualizado com sucesso'
    expect(page).to have_content 'Status: Em rota de entrega'
  end

  it 'e edita capacidade máxima de carga com sucesso' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, model: 'Fusca', load_capacity: 300)
    Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, model: 'Fusca', load_capacity: 3600)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Detalhes - CDE1000'
    click_on 'Editar cadastro'
    fill_in 'Capacidade máxima de carga', with: 1000
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Veículo atualizado com sucesso'
    expect(page).to have_content 'Capacidade máxima de carga: 1000kg'
    expect(page).not_to have_content 'Capacidade máxima de carga: 3600kg'
    
  end

  it 'e edita placa com sucesso' do       
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, model: 'Fusca', load_capacity: 300)
    Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, model: 'Fusca', load_capacity: 3600)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Detalhes - CDE1000'
    click_on 'Editar cadastro'
    fill_in 'Placa', with: 'CDF1000'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Veículo atualizado com sucesso'
    expect(page).to have_content 'Placa: CDF1000'
    expect(page).not_to have_content 'CDE1000'
  end
  
  it 'e edita modelo com sucesso' do       
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)    
    car = VehicleType.create!(vehicle_type: :car)
    utility = VehicleType.create!(vehicle_type: :utility_vehicle)
    Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: car, model: 'Fusca', load_capacity: 300)
    Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: utility, model: 'BestA', load_capacity: 3600)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Detalhes - CDE1000'
    click_on 'Editar cadastro'
    fill_in 'Modelo', with: 'Kombi'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Veículo atualizado com sucesso'
    expect(page).to have_content 'Modelo: Kombi'
    expect(page).not_to have_content 'BestA'
  end
end