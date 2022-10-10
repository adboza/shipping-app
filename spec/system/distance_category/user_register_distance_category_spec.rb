require 'rails_helper'

describe 'Usuário registra valores e distâncias da modalidade' do
  it 'a partir da tela inicial com sucesso' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Cadastrar Preços por Distância'
    fill_in 'Distância mínima', with: 100
    fill_in 'Distância máxima', with: 10000
    fill_in 'Preço por km', with: 0.5
    fill_in 'Prazo de entrega', with: 36
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Preço por distância incluído'
    within('#distance_categories') do
      expect(page).to have_content '0km - 10km'
      expect(page).to have_content '0,50'
      expect(page).to have_content '36h'
      expect(page).to have_content 'Expressa'
    end
  end
  # it 'a partir da tela inicial com erro' do
  #   #Arrange
  #   user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
  #   login_as(user)
  #   DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    
  #   #Act
  #   visit root_path
  #   click_on 'Modalidades de Entrega'
  #   click_on 'Expressa'
  #   click_on 'Cadastrar Preços por Distância'
  #   fill_in 'Distância mínima', with: 100
  #   fill_in 'Distância máxima', with: 10000
  #   fill_in 'Preço por km', with: ''
  #   click_on 'Salvar'
  #   #Assert
  #   expect(page).to have_content 'alguma coisa deu errado'
    
  # end
end