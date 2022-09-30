Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :load_categories, only: [:index, :show, :new, :create]
end
