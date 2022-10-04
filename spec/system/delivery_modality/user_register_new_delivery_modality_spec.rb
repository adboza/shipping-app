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
    expect(page).to have_content('Taxa inicial')
  end
  it 'com sucesso' do
    #Arrange
    
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
    DeliveryModality.create!(mod_name: 'Ecológica', mod_price: 4)
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Cadastrar Modalidade'
    
    fill_in('Nome modalidade', with: 'Ecológica')
    fill_in 'Taxa inicial', with: '4'
    
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Não foi possível cadastrar a modalidade'
    expect(current_path).to eq delivery_modalities_path
  end
end