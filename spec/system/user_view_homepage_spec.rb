require 'rails_helper'

describe 'Usuario visita tela inicial' do
 
  it 'e vê o nome da app' do
    # Arrange

    #Act
    visit(root_path)

    #Assert
    expect(page).to have_content('Galactic e-Commerce')
    expect(page).to have_content('Gerenciamento de frota de entregas')
    expect(page).to have_link('Gerenciamento de frota de entregas', href: root_path)
  end

  it 'e vê link para preços por peso' do
    # Arrange

    #Act
    visit root_path 
    #Assert    
    expect(page).to have_link 'Preços por peso'
  end


end