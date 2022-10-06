require 'rails_helper'

describe 'Usuário vê detalhes da modalidade' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    #click_on ''
    #Assert
    #expect(page).to have_content('Modalidade de Entrega Expressa')
        
  end
  
end