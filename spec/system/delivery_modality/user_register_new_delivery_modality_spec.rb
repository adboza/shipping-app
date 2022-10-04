require 'rails_helper'

describe 'Usuário cadastra uma modalidade de entrega' do
  it 'a partir da tela inicial' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Cadastrar Modalidade'
    #Assert
    expect(page).to have_content 'Nome modalidade'
    expect(page).to have_content('Taxa inicial de entrega')
  end
end