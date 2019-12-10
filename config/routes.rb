Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :clients, only: [:index, :show, :new, :create]
  resources :car_models
  resources :cars
  resources :rentals do
    post 'start', on: :member
    get 'search', on: :collection
  end
end
