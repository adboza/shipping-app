require 'rails_helper'

describe 'Usuário vê veículos cadastrados' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    #Act
    visit root_path
    click_on 'Veículos'
    #Assert
    expect(page).to have_link 'Veículos'
    expect(current_path).to eq vehicles_path
  end

  it 'e vê lista de veículos' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')
    login_as(user)
    tipo = VehicleType.create!(vehicle_type: :motorcycle)
    Vehicle.create!(vehicle_type: tipo, licence_plate: 'ABC4344', year: 2022, status: :available)
    #Act
    visit root_path
    click_on 'Veículos'
    #Assert
    within('main') do
      expect(page).to have_content 'Veículos'
    end
    expect(page).to have_content 'ABC4344'
    expect(page).to have_content '2022'
  end

  # it 'e não vê modalidades cadastradas' do
  #   #Arrange
  #   user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')
  #   login_as(user)
  #   #Act
  #   visit root_path
  #   click_on 'Modalidades de Entrega'
  #   #Assert
  #   within('main') do
  #     expect(page).to have_content 'Modalidades de Entrega'
  #   end
  #   expect(page).not_to have_content 'Nome modalidade: Ecológica'
  #   expect(page).to have_content 'Não existem modalidades cadastradas'
  # end
end