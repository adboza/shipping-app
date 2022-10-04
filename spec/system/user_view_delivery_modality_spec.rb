require 'rails_helper'

describe 'Usuário vê modalidades de entrega' do
  it 'a partir do menu' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    #Assert
    expect(page).to have_link 'Modalidades de Entrega'
    expect(current_path).to eq delivery_modalities_path
  end
end