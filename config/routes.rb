Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :delivery_modalities, only: [:index, :new, :create, :show, :update, :edit] do
    resources :load_categories, only: [:new, :create, :show, :edit, :update]
    resources :distance_categories, only: [:new, :create, :show, :edit, :update]    
  end

  resources :vehicle_type_selections, only: [:new, :create]
  
  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update] do
    get 'search', on: :collection
  end

  resources :service_orders, only: [:index, :new, :show, :create, :edit, :update] do
    get 'pending', on: :collection
    get 'search', on: :collection
    resources :shipping_orders, only: [:new, :create, :edit, :update]    
  end

end
