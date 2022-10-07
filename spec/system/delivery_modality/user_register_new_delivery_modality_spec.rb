require 'rails_helper'

describe 'Usuário cadastra uma modalidade de entrega' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Cadastrar Modalidade'
    #Assert
    expect(page).to have_content 'Nome modalidade'
    expect(page).to have_content('Taxa inicial')
  end
  it 'com sucesso' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Cadastrar Modalidade'
    
    fill_in('Nome modalidade', with: 'Ecológica')
    fill_in 'Taxa inicial', with: '4'
    
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Modalidade cadastrada com sucesso'
    expect(page).to have_content 'Ecológica'
  end
  it 'com falha' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Ecológica', mod_price: 4)
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Cadastrar Modalidade'
    
    fill_in('Nome modalidade', with: 'Ecológica')
    fill_in 'Taxa inicial', with: ''
    
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Não foi possível cadastrar a modalidade'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Nome modalidade já está em uso'
    expect(page).to have_content 'Taxa inicial não pode ficar em branco'
    expect(current_path).to eq delivery_modalities_path
  end

  it 'e não é usuário administrador' do
    #Arrange
    user = User.create!(name:'Edna', email:'edna@email.com', password:'123456', user_access: :regular_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
 
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    #Assert    
    expect(page).not_to have_content 'Cadastrar Modalidade'    
  end
end