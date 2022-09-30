require 'rails_helper'

describe 'Usuario visita tela inicial' do
 it 'e acessa link para preço de frete por categoria de peso' do
    #Arrange
    LoadCategory.create!(min_weight: 0, max_weight: 10, weight_dist_price: 0.5)
    LoadCategory.create!(min_weight: 11, max_weight: 30, weight_dist_price: 0.8)

    #Act
    visit root_path
    click_on 'Preços por peso'    

    #Assert    
    expect(page).to have_content 'Preços por peso'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'Valor por km'
    expect(page).to have_text '0kg - 10kg'
    expect(page).to have_content 'R$ 0.5'
    expect(page).to have_content '11kg - 30kg'
    expect(page).to have_content 'R$ 0.8'
  end

end