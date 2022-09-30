Rails.application.routes.draw do
  root to: 'home#index'

  resources :load_categories, only: [:index, :show, :new, :create]
end
