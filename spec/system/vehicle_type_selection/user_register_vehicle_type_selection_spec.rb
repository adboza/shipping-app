require 'rails_helper'

describe 'Usuário registra categorias de veículos por modalidade' do
  it 'a partir da tela inicial' do
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :admin_user)
    utilitario = VehicleType.create!(vehicle_type: :utility_vehicle)
    carro = VehicleType.create!(vehicle_type: :car)
    expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    ecologica = DeliveryModality.create!(mod_name: 'Ecológica', mod_price: '7')
    login_as(user)

    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Cadastrar Categorias de Veículos'
    select 'car', from: 'Tipo de veículo'
    select 'Expressa', from: 'Modalidade'
    click_on 'Salvar'
   
    expect(page).to have_content 'Categoria de veículo incluída na modalidade' 
  end
  
end