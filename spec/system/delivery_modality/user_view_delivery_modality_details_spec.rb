require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    #Arrange
    
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    #Assert
    expect(page).to have_content('Modalidade de Entrega Expressa')
        
  end
end