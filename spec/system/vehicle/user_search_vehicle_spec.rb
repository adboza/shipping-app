require 'rails_helper'

describe 'Usuário busca por uma encomenda' do
  it 'a partir do menu' do
    user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
 
    login_as(user)
    visit root_path
    click_on 'Veículos'    
    
    expect(page).to have_field('Buscar Veículo:')
    expect(page).to have_button('Buscar')
    
  end
  
  it 'e encontra um' do
    user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    carro = VehicleType.create!(vehicle_type: :car)
    moto = VehicleType.create!(vehicle_type: :motorcycle)
    fusca1 = Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)
    cg1 = Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: moto, model: 'CG-125', load_capacity: 36)

    login_as(user)
    visit root_path
    click_on 'Veículos'  
    within 'main' do
      fill_in 'Buscar Veículo:', with: 'CDE1000'
      click_on 'Buscar'
    end
    
    expect(page).to have_content "Resultados da Busca por: CDE1000"
    expect(page).to have_content 'Modelo: CG-125'
    expect(page).to have_content "Ano: 2021"
  end

  it 'e encontra múltiplos veículos' do
    user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    carro = VehicleType.create!(vehicle_type: :car)
    moto = VehicleType.create!(vehicle_type: :motorcycle)
    fusca1 = Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 20.years.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)
    cg1 = Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: moto, model: 'CG-125', load_capacity: 36)

    login_as(user)
    visit root_path
    click_on 'Veículos'  
    within 'main' do
      fill_in 'Buscar Veículo:', with: '100'
      click_on 'Buscar'
    end
    
    expect(page).to have_content "Resultados da Busca por: 100"
    expect(page).to have_content 'Modelo: CG-125'
    expect(page).to have_content "Ano: 2021"
    expect(page).to have_content 'Modelo: Fusca'

  end
end