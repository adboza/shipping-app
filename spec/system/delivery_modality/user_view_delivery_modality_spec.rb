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
  it 'e vê lista de modalidades' do
    #Arrange
    DeliveryModality.create!(mod_name: 'Ecológica', mod_price: 4)
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    #Assert
    within('main') do
      expect(page).to have_content 'Modalidades de Entrega'
    end
    expect(page).to have_content 'Nome modalidade: Ecológica'
    expect(page).to have_content 'Taxa inicial: R$ 4'
  end
  it 'e não vê modalidades cadastradas' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    #Assert
    within('main') do
      expect(page).to have_content 'Modalidades de Entrega'
    end
    expect(page).not_to have_content 'Nome modalidade: Ecológica'
    expect(page).to have_content 'Não existem modalidades cadastradas'
  end
end