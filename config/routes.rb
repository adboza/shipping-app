Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :delivery_modalities, only: [:index, :new, :create, :show, :update, :edit] do
    resources :load_categories, only: [:new, :create, :show, :edit, :update]
    resources :distance_categories, only: [:new, :create, :show, :edit, :update]
  end
  

end
