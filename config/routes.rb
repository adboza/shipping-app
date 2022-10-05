Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :load_categories, only: [:index, :new, :create]
  resources :delivery_modalities, only: [:index, :new, :create, :show, :update, :edit]

end
