require 'rails_helper'

describe 'Usuario visita tela inicial' do
 
  it 'e vê o nome da app' do
    
    visit root_path

    expect(page).to have_content('Galactic e-Commerce')
    expect(page).to have_content('Gerenciamento de frota de entregas')
    expect(page).to have_link('Gerenciamento de frota de entregas', href: root_path)
  end

  it 'e realiza login com sucesso' do
    
    User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joao@sistemadefrete.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Modalidades de Entrega'
    expect(page).not_to have_link('Entrar', href: new_user_session_path)
    expect(page).to have_button('Sair')
  end
end