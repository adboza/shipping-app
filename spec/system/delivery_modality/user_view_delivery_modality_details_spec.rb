require 'rails_helper'

describe 'Usuário vê detalhes da modalidade' do
  it 'a partir da tela inicial' do
    
    user = User.create!(name:'Joao', email:'joao@sistemadefrete.com.br', password:'123456')
    login_as(user)
    DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    
    visit root_path
    click_on 'Modalidades de Entrega'
    click_on 'Expressa'
   
    expect(page).to have_content 'Modalidade de Entrega Expressa'
    expect(page).to have_content 'Preços por peso'        
  end  
end