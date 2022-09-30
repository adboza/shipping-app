Rails.application.routes.draw do
  root to: 'home#index'

  resources :load_categories, only: [:show]
end
