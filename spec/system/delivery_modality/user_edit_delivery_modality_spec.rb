require 'rails_helper'

describe 'Usuário edita um Fornecedor' do
  it 'a partir da página de detalhes do fornecedor' do
    #Arrange    
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
 
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Editar'
    #Assert
    expect(page).to have_content 'Editar Modalidade'
    
  end
  it 'com sucesso' do
    #Arrange    
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
 
    #Act
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
    click_on 'Editar'
    fill_in 'Nome modalidade', with:'Rápida'
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Modalidade atualizada com sucesso'
    expect(page).to have_content 'Nome modalidade: Rápida'
    expect(page).not_to have_content 'Expressa'
    
  end
end