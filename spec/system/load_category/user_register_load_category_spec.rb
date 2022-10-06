require 'rails_helper'

describe 'Usuário registra valores e pesos da modalidade' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name:'Joao', email:'joao@email.com', password:'123456', user_access: :admin_user)
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Cadastrar Preços por Peso'
    fill_in 'Peso mínimo', with: 0
    fill_in 'Peso máximo', with: 10
    fill_in 'Preço por km', with: 0.5
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Expressa'
    expect(page).to have_content '0kg - 10kg'
    expect(page).to have_content 'R$ 0.5'

        
  end
  
end