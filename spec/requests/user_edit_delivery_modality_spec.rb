require 'rails_helper'

describe 'Usuário edita uma modalidade de entrega' do
  it 'e não tem acesso admin' do
    #Arrange
    user = User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'123456', user_access: :regular_user)
    login_as(user)
    delivery_modality = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
    #Act
    login_as(user) 
    patch(delivery_modality_path(delivery_modality.id), params: {mod_name: 'Itinerante'})
    #Assert
    expect(response).to redirect_to(root_path)
  end
end